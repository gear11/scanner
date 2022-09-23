import 'package:flutter/material.dart';
import 'animated_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/counter.dart';

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    print("Building counter!");

    final counter = ref.watch(counterProvider);
    final notifier = ValueNotifier<String>("--");

    return counter.when(
      data: (count) {
        notifier.value = "$count";
        return Row(children: [const Text("Counter"), AnimatedText(notifier)]);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }
}
