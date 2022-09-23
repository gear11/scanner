import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class WatchList extends StatelessWidget {
  const WatchList({Key? key}) : super(key: key);

  static final watchListDoc = gql(r'''
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

  @override
  Widget build(context) {
    print("Building watch list!");
    return Query(
      options: QueryOptions(
        document: watchListDoc,
        pollInterval: const Duration(seconds: 5),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (hasErrors(result)) {
          return buildErrors(result);
        }
        if (result.isLoading) {
          return buildLoading();
        }

        final resp = data(result);

        // it can be either Map or List
        List items = resp['items'];
        return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final tickBar = items[index];
              final wap = tickBar['wap'];
              return ListTile(
                  leading: Text(tickBar['symbol']), title: Text("$wap"));
            });
      },
    );
  }
}

Map<String, dynamic> data(QueryResult result) {
  if (result.data == null) {
    return {};
  }
  final list = result.data!.values.toList();
  if (list.length == 1) {
    return list[0];
  } else {
    return list[1];
  }
}

bool hasErrors(QueryResult result) {
  return result.hasException || !data(result)['success'];
}

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrors(QueryResult result) {
  if (!hasErrors(result)) {
    throw ArgumentError('Result has no error');
  }

  if (result.hasException) {
    if (result.exception?.linkException?.originalException?.message ==
        'Connection refused') {
      return const Text(
          "A connection to the server could not be established. Retrying.");
    } else {
      return Text(result.exception.toString());
    }
  }

  final errors = result.data!.entries.first.value['errors'];
  return ListView.builder(
      itemCount: errors.length,
      itemBuilder: (context, index) {
        return Text(errors[index]);
      });
}

class SymbolList extends StatelessWidget {
  const SymbolList({Key? key}) : super(key: key);

  static final listSymbolsDoc = gql(r'''
  query listSymbols {
    listSymbols {
      success
      errors
      symbols {
        name
      }
    }
  }
  ''');

  @override
  Widget build(context) {
    print("Building symbols list!");
    return Query(
      options: QueryOptions(
        document: listSymbolsDoc,
        pollInterval: const Duration(seconds: 10),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (hasErrors(result)) {
          return buildErrors(result);
        }

        if (result.isLoading) {
          return buildLoading();
        }

        // it can be either Map or List
        List symbols = data(result)['symbols'];

        return ListView.builder(
            itemCount: symbols.length,
            itemBuilder: (context, index) {
              return Text(symbols[index]['name']);
            });
      },
    );
  }
}
