import 'package:flutter/material.dart';
import '../providers/logging.dart';

final log = logger(Freezable);

class Freezable extends StatefulWidget {
  const Freezable(
      {super.key,
      required this.frozen,
      required this.child,
      this.opacity = 0.5});
  final bool frozen;
  final Widget child;
  final double opacity;

  @override
  State<Freezable> createState() => _FrozenState();
}

class _FrozenState extends State<Freezable> {
  Widget? savedChild;
  @override
  Widget build(BuildContext context) {
    log.info('Rebuilding frozen state ${widget.frozen}');
    if (!widget.frozen) {
      savedChild = widget.child;
      return widget.child;
    }
    return (savedChild != null)
        ? Opacity(opacity: widget.opacity, child: savedChild)
        : const Text('FROZEN');
  }
}
