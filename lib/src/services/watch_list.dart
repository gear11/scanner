import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/watch_list.dart';
import '../providers/connection.dart';

const _watchListResult = '''
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
''';

final _watchListDoc = gql('''
    query getWatchList {
      getWatchList {
        $_watchListResult
      }
    }
    ''');

final _addSymbolDoc = gql('''
  mutation AddSymbol(\$symbol: String!) {
    action: addSymbol(input: {symbol: \$symbol}) {
        $_watchListResult
    }
  }
''');

final _removeSymbolDoc = gql('''
  mutation RemoveSymbol(\$symbol: String!) {
    action: removeSymbol(symbol: \$symbol) {
        $_watchListResult
    }
  }
''');

WatchList _fromItems(List<dynamic> items) {
  return WatchList(
      items.map((item) => WatchListItem.fromMap(item)).toList(growable: false));
}

class WatchListService {
  WatchListService(this.client);
  final ConnectionWrapper<GraphQLClient> client;
  final options = QueryOptions(
    document: _watchListDoc,
    fetchPolicy: FetchPolicy.noCache,
  );

  Future<WatchList> fetch() async {
    final QueryResult result = await client.get().query(options);
    if (result.hasException) {
      client.reset();
      throw result.exception!;
    } else {
      return _fromItems(result.data!['getWatchList']['items']);
    }
  }

  Future<WatchList> add(String symbol) async {
    final MutationOptions options = MutationOptions(
      document: _addSymbolDoc,
      variables: <String, dynamic>{
        'symbol': symbol,
      },
    );

    final QueryResult result = await client.get().mutate(options);
    if (result.hasException) {
      client.reset();
      throw result.exception!;
    } else {
      return _fromItems(result.data!['action']['items']);
    }
  }

  Future<WatchList> remove(String symbol) async {
    return _mutate(_removeSymbolDoc, symbol);
  }

  Future<WatchList> _mutate(mutateDoc, String symbol) async {
    final MutationOptions options = MutationOptions(
      document: mutateDoc,
      variables: <String, dynamic>{
        'symbol': symbol,
      },
    );

    final QueryResult result = await client.get().mutate(options);
    if (result.hasException) {
      client.reset();
      throw result.exception!;
    } else {
      return _fromItems(result.data!['action']['items']);
    }
  }
}
