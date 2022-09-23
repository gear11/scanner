import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
  final subscription = client.subscribe(
    SubscriptionOptions(document: _counterSubscriptionDoc),
  );
  return subscription
      .map((QueryResult<Object?> result) => result.data?['counter']?['count']);
});
