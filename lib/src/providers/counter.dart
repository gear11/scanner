import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';

final clientProvider = Provider((ref) {
  final httpLink = HttpLink("http://127.0.0.1:8000");
  final websocketLink = WebSocketLink("ws://127.0.0.1:8000");
  final link =
      Link.split((request) => request.isSubscription, websocketLink, httpLink);
  return GraphQLClient(cache: GraphQLCache(store: InMemoryStore()), link: link);
});

final _counterSubscriptionDoc = gql(
  r'''
      subscription counter {
        counter {
          success
          errors
          count
        }
      }
    ''',
);

final counterProvider = StreamProvider.autoDispose<int>((ref) {
  final client = ref.watch(clientProvider);
  return createSubscriptionStream(client, _counterSubscriptionDoc,
      (QueryResult<Object?> result) => result.data?['counter']?['count']);
});

Stream<T> createSubscriptionStream<T>(
    GraphQLClient client, document, T Function(QueryResult<Object?>) mapper) {
  final subscription = client.subscribe(
    SubscriptionOptions(document: document),
  );
  return subscription.map(mapper);
}
