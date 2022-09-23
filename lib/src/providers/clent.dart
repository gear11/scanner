import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final clientProvider = Provider((ref) {
  final httpLink = HttpLink("http://127.0.0.1:8000");
  final websocketLink = WebSocketLink("ws://127.0.0.1:8000");
  final link =
      Link.split((request) => request.isSubscription, websocketLink, httpLink);
  return GraphQLClient(cache: GraphQLCache(store: InMemoryStore()), link: link);
});
