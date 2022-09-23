import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText(this.notifier, {super.key});

  final ValueNotifier<String> notifier;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.notifier,
        builder: (context, text, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              text,
              // This key causes the AnimatedSwitcher to interpret this as a "new"
              // child each time the count changes, so that it will begin its animation
              // when the count changes.
              key: ValueKey<String>(text),
              style: Theme.of(context).textTheme.headline4,
            ),
          );
        });
  }
}
