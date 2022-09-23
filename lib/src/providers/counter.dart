import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'clent.dart';

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
