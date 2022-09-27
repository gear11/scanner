import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/watch_list.dart';
import '../providers/watch_list.dart';
import '../providers/logging.dart';
import 'util.dart';

final _log = logger(currentFile);

class SymbolSearchDelegate extends SearchDelegate {
  SymbolSearchDelegate()
      : super(
          searchFieldLabel: 'Enter a symbol',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    _log.info('Building suggestions');
    if (query.length < 2) {
      return Container();
    }
    return SearchResultsWidget(this);
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultsWidget(this);
  }

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[];
}

class SearchResultsWidget extends ConsumerWidget {
  const SearchResultsWidget(this.delegate, {super.key});

  final SearchDelegate delegate;

  @override
  Widget build(BuildContext context, ref) {
    final query = delegate.query;
    if (query.length < 2) {
      return Container();
    }
    final val = ref.watch(symbolSearchResultsProvider(query));
    return val.when(
        data: (symbols) {
          _log.info('Finally rendering search results');
          return SymbolInfoList(symbols);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          return ErrorWidget([e, st]);
        });
  }
}

class SymbolInfoList extends StatelessWidget {
  const SymbolInfoList(this.symbols, {super.key});

  final List<SymbolInfo> symbols;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: symbols.length,
        itemBuilder: (context, index) => SymbolListTile(
              symbols[index].symbol,
              subtitle: symbols[index].companyName,
              trailing: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add ${symbols[index].symbol}',
                  onPressed: () {} // => onRemove(ref, item.symbol),
                  ),
            ));
  }
}
