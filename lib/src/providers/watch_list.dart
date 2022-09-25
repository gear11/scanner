import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'connection.dart';
import '../models/watch_list.dart';
import '../services/watch_list.dart';
import 'client.dart';
import 'logging.dart';

final connEvents = StreamController<ConnectionEvent>();

final log = logger(currentFile);

class WiredWatchListService {
  WiredWatchListService(
      ConnectionWrapper<GraphQLClient> client, this.connEvents)
      : service = WatchListService(client);

  final WatchListService service;
  final watchlistEvents = StreamController<WatchList>();
  final StreamController<ConnectionEvent> connEvents;
  bool _loopStarted = false;

  Future<void> startRefreshLoop() async {
    if (_loopStarted) {
      log.warning('Loop already started');
    }
    _loopStarted = true;
    log.warning('Starting watch list loop');
    try {
      while (true) {
        const action = 'Refresh watchlist';
        try {
          final watchlist = await service.fetch();
          _onWatchList(watchlist, action);
        } catch (ex) {
          _onError(ex, action);
        } finally {
          await Future.delayed(const Duration(seconds: 5));
        }
      }
    } finally {
      log.severe('Exiting watch list update loop!');
    }
  }

  Future<void> remove(String symbol) async {
    final action = 'Update from remove $symbol';
    service.remove(symbol).then((w) => _onWatchList(w, action),
        onError: (e) => _onError(e, action));
  }

  Future<WatchList> fetch() async {
    const action = 'Fetching watchlist';
    return service.fetch().then((w) {
      _onWatchList(w, action);
      return w;
    }, onError: (e) => _onError(e, action));
  }

  void _onWatchList(WatchList watchlist, String msg) {
    watchlistEvents.add(watchlist);
    connEvents.add(ConnectionEvent(msg));
  }

  void _onError(dynamic e, String msg) {
    log.warning('Error on action $msg: $e');
    connEvents.add(ConnectionEvent(e, isError: true));
  }
}

final watchListServiceProvider = Provider<WiredWatchListService>((ref) {
  final client = ref.watch(clientProvider);
  final connEvents = ref.watch(websocketLinkProvider).events;
  final service = WiredWatchListService(client, connEvents);
  return service;
});

final watchListUpdateProvider =
    StreamProvider.autoDispose<WatchList>((ref) async* {
  final watchlistService = ref.read(watchListServiceProvider);
  watchlistService.startRefreshLoop();
  yield* watchlistService.watchlistEvents.stream;
});
