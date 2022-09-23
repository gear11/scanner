import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/watch_list.dart';

class WatchList extends ConsumerWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final counter = ref.watch(watchListProvider);
    return counter.when(
      data: (items) {
        return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                  leading: Text(item.symbol), title: Text(item.wap.toString()));
            });
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }
}
