import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/watch_list.dart';
import '../providers/watch_list.dart';
import '../providers/logging.dart';
import 'util.dart';

final _log = logger(currentFile);

class SymbolSearchDelegate extends SearchDelegate {
  SymbolSearchDelegate(this.ref)
      : super(
          searchFieldLabel: 'Company name or symbol',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  final WidgetRef ref;
  final List<SymbolInfo> results = [];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    _log.fine('Building suggestions');
    if (query.length < 2) {
      return Container();
    }
    return SearchResultsWidget(this);
  }

  @override
  Widget buildResults(BuildContext context) {
    if (results.length == 1) {
      _log.warning("Adding watchlist symbol ${results[0]}");
      ref
          .read(watchListServiceProvider)
          .add(results[0].symbol)
          .then(Navigator.of(context).pop);
      return Container();
    }
    // Otherwise, 0 or multiple results, no change
    return SearchResultsWidget(this);
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
      ];
}

class SearchResultsWidget extends ConsumerWidget {
  const SearchResultsWidget(this.delegate, {super.key});

  final SymbolSearchDelegate delegate;

  @override
  Widget build(BuildContext context, ref) {
    final query = delegate.query;
    if (query.length < 2) {
      return Container();
    }
    final val = ref.watch(symbolSearchResultsProvider(query));
    return val.when(
        data: (symbols) {
          delegate.results.clear();
          delegate.results.addAll(symbols);
          return SymbolInfoList(symbols);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          return ErrorWidget([e, st]);
        });
  }
}

class SymbolInfoList extends ConsumerWidget {
  const SymbolInfoList(this.symbols, {super.key});

  final List<SymbolInfo> symbols;

  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
        itemCount: symbols.length,
        itemBuilder: (context, index) => SymbolListTile(
              symbols[index].symbol,
              subtitle: symbols[index].companyName,
              trailing: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add ${symbols[index].symbol}',
                  onPressed: () {
                    _log.info('Adding ${symbols[index].symbol}');
                    ref
                        .read(watchListServiceProvider)
                        .add(symbols[index].symbol);
                  }),
            ));
  }
}
