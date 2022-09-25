import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'connection.dart';

final connectionStatusProvider =
    StateNotifierProvider<ConnectionNotifier, ConnectionStatus>(
        (ref) => ConnectionNotifier());

final websocketLinkProvider =
    Provider((ref) => MyWebSocketLink("ws://127.0.0.1:5000"));

final connectionEventProvider = StreamProvider((ref) {
  final controller = ref.watch(websocketLinkProvider).events;
  return controller.stream.map((event) {
    ref.read(connectionStatusProvider.notifier).notify(event);
    return event;
  });
});

final clientProvider = Provider<ConnectionWrapper<GraphQLClient>>((ref) {
  return ConnectionWrapper<GraphQLClient>(() {
    final httpLink = HttpLink("http://127.0.0.1:5000");
    final websocketLink = ref.watch(websocketLinkProvider);
    final link = Link.split(
        (request) => request.isSubscription, websocketLink, httpLink);
    return GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()), link: link);
  });
});

// This is copy-pasta from GraphQL client, but I need the Socket Client
// so that I can get a disconnect notification stream
class MyWebSocketLink extends Link {
  /// Creates a new [WebSocketLink] instance with the specified config.
  MyWebSocketLink(
    this.url, {
    this.config = const SocketClientConfig(),
  });

  final String url;
  final SocketClientConfig config;
  final events = StreamController<ConnectionEvent>();

  // cannot be final because we're changing the instance upon a header change.
  MySocketClient? _socketClient;

  @override
  Stream<Response> request(Request request, [forward]) async* {
    if (_socketClient == null) {
      connectOrReconnect();
    }

    yield* _socketClient!.subscribe(request, true);
  }

  /// Connects or reconnects to the server with the specified headers.
  void connectOrReconnect() {
    _socketClient?.dispose();
    _socketClient = MySocketClient(url,
        config: config, events: events, onMessage: onMessage);
  }

  void onMessage(GraphQLSocketMessage msg) {
    events.add(ConnectionEvent('Received message of type "${msg.type}"'));
  }

  /// Disposes the underlying socket client explicitly. Only use this, if you want to disconnect from
  /// the current server in favour of another one. If that's the case, create a new [WebSocketLink] instance.
  @override
  Future<void> dispose() async {
    await _socketClient?.dispose();
    _socketClient = null;
  }
}

class MySocketClient extends SocketClient {
  MySocketClient(super.url,
      {required super.config, required this.events, super.onMessage});

  final StreamController<ConnectionEvent> events;

  @override
  void onConnectionLost([Object? e]) async {
    super.onConnectionLost(e);
    events.add(ConnectionEvent(e ?? "Unknown error causing conneciton lost",
        isError: true));
  }
}
