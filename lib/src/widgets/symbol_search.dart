import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/watch_list.dart';
import '../providers/watch_list.dart';
import '../providers/logging.dart';
import 'util.dart';

final _log = logger(currentFile);

class SymbolSearchDelegate extends SearchDelegate {
  SymbolSearchDelegate(this.ref, this.redraw)
      : super(
          searchFieldLabel: 'Enter a symbol',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  final WidgetRef ref;
  final Function redraw;

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) {
      return Container();
    }
    return ref.watch(symbolSearchResultsProvider(query)).when(
        data: (symbols) {
          _log.info('Finally rendering search results');
          return SymbolInfoList(symbols);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          return ErrorWidget([e, st]);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return ref.watch(symbolSearchResultsProvider(query)).when(
        data: (symbols) => SymbolInfoList(symbols),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          return Center(child: Text(e.toString()));
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[];
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
