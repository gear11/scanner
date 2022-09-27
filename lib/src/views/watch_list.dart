import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/src/widgets/symbol_search.dart';

import '../settings/settings_view.dart';
import '../widgets/watch_list.dart';
import '../widgets/counter.dart';
import '../widgets/connection_status.dart';
import 'add_symbol.dart';

/// Displays a list of SampleItems.
class WatchListView extends ConsumerStatefulWidget {
  const WatchListView({super.key});

  static const routeName = '/';

  @override
  createState() => _WatchListViewState();
}

class _WatchListViewState extends ConsumerState<WatchListView> {
  @override
  Widget build(BuildContext context) {
    //ref.watch(symbolSearchResultsProvider(query)
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add symbol',
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate:
                          SymbolSearchDelegate(ref, () => {setState(() => {})}),
                    );
                  },
                ))
          ],
          title: const Text('Watchlist'),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(flex: 8, child: WatchList()),
                  Expanded(flex: 1, child: Counter()),
                  Expanded(flex: 1, child: ConnectionStatusWidget()),
                ])));
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
