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
      final symbolInfo = results[0];
      final watchListService = ref.watch(watchListServiceProvider);
      if (watchListService.current.has(symbolInfo.symbol)) {
        Future.delayed(Duration.zero, Navigator.of(context).pop);
      } else {
        final action = "Added ${symbolInfo.symbol} to watchlist";
        _log.info(action);
        watchListService
            .add(results[0].symbol)
            .then(Navigator.of(context).pop)
            .then((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(action)));
        });
      }
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
    final watchListService = ref.watch(watchListServiceProvider);
    ref.watch(watchListUpdateProvider);
    return ListView.builder(
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          final symbol = symbols[index].symbol;
          final inWatchlist = watchListService.current.has(symbol);
          final addOrRemove = inWatchlist
              ? IconButton(
                  icon: const Icon(Icons.remove),
                  tooltip: 'Remove $symbol',
                  onPressed: _removeCB(context, watchListService, symbol))
              : IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add $symbol',
                  onPressed: _addCB(context, watchListService, symbol));

          return SymbolListTile(
            symbol,
            subtitle: symbols[index].companyName,
            trailing: addOrRemove,
          );
        });
  }

  _addCB(context, WiredWatchListService service, symbol) {
    return () {
      service.add(symbol);
      final action = 'Added $symbol to watchlist';
      _log.info(action);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(action)));
    };
  }

  _removeCB(context, WiredWatchListService service, symbol) {
    return () {
      service.remove(symbol);
      final action = 'Removed $symbol from watchlist';
      _log.info(action);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(action)));
    };
  }
}
