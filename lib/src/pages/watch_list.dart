import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../widgets/watch_list.dart';
import '../widgets/counter.dart';

/// Displays a list of SampleItems.
class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        //body: Center(child: Row(children: const [WatchList(), Counter()])));
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(flex: 1, child: WatchList()),
                  Expanded(flex: 1, child: Counter())
                ])));
  }
}
