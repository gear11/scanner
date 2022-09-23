import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'client.dart';
import '../models/watch_list.dart';

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
  final options = QueryOptions(
    document: _watchListDoc,
    fetchPolicy: FetchPolicy.noCache,
  );

  print('Starting watch list provider loop');

  while (true) {
    final QueryResult result = await client.query(options);
    print('Updating');
    if (result.hasException) {
      print('Provider exception: ${result.exception}');
      Future.delayed(const Duration(seconds: 3),
          () => ref.refresh(clientProvider)); // Retry
      throw result.exception!;
    }
    final List<dynamic> items = result.data!['getWatchList']['items'];
    yield items
        .map((item) => WatchListItem.fromMap(item))
        .toList(growable: false);
    await Future.delayed(const Duration(seconds: 5));
  }
});
