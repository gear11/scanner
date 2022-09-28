import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/src/widgets/symbol_search.dart';

import '../widgets/watch_list.dart';
import '../widgets/counter.dart';
import '../widgets/connection_status.dart';
import '../providers/logging.dart';

final _log = logger(currentFile);

/// Displays a list of SampleItems.
class WatchListView extends ConsumerWidget {
  const WatchListView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add symbol',
                  onPressed: () {
                    final symbol = showSearch(
                      context: context,
                      delegate: SymbolSearchDelegate(ref),
                    );
                    _log.info('Adding $symbol');
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
                  //Expanded(flex: 1, child: Counter()),
                  Expanded(flex: 1, child: ConnectionStatusWidget()),
                ])));
  }
}
