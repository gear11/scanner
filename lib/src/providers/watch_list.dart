import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'client.dart';
import '../models/watch_list.dart';
import '../providers/logging.dart';

final log = logger(currentFile);

final _watchListDoc = gql(r'''
    query getWatchList {
      getWatchList {
        success
        errors
        items {
          symbol
          date
          open
          high
          low
          close
          wap
          volume
        }
      }
    }
    ''');

final watchListProvider =
    StreamProvider.autoDispose<List<WatchListItem>>((ref) async* {
  final client = ref.watch(clientProvider);
  final connEvents = ref.watch(websocketLinkProvider).events;
  final options = QueryOptions(
    document: _watchListDoc,
    fetchPolicy: FetchPolicy.noCache,
  );

  log.warning('Restarting watch list loop');
  try {
    while (true) {
      final QueryResult result = await client.get().query(options);
      if (result.hasException) {
        log.warning('WatchList query error');
        connEvents.add(ConnectionEvent(result.exception!, isError: true));
        //await Future.delayed(const Duration(seconds: 3),
        //    () => ref.refresh(clientProvider)); // Retry
        //throw result.exception!;
        client.reset();
      } else {
        log.info('WatchList query success');
        connEvents.add(ConnectionEvent('Received watch list response'));
        final List<dynamic> items = result.data!['getWatchList']['items'];
        yield items
            .map((item) => WatchListItem.fromMap(item))
            .toList(growable: false);
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  } finally {
    log.warning('Exiting watch list loop!');
  }
});
