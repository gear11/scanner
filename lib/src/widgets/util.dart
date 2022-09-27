import 'package:flutter/material.dart';
import '../providers/logging.dart';

final log = nullLogger(currentFile);

class SymbolListTile extends StatelessWidget {
  const SymbolListTile(this.symbol, {this.subtitle, this.trailing, super.key});

  final String symbol;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ColoredCircleAvatar(symbol),
      title: Text(symbol),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
    );
  }
}

class ColoredCircleAvatar extends StatelessWidget {
  const ColoredCircleAvatar(this.text, {Key? key, this.fromColors = const []})
      : super(key: key);

  final String text;
  final List<Color> fromColors;

  @override
  Widget build(context) {
    Color bg = Theme.of(context).colorScheme.background;

    final hashCode = text.hashCode;
    if (fromColors.isEmpty) {
      final r = 100 + (13 * hashCode) % 155;
      final g = 100 + (59 * hashCode) % 155;
      final b = 100 + (19 * hashCode) % 155;
      bg = Color.fromRGBO(r, g, b, 1.0);
    } else {
      bg = fromColors[(17 * hashCode) % fromColors.length];
    }

    return CircleAvatar(
      backgroundColor: bg,
      child: Text(text[0]),
    );
  }
}

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
    if (widget.frozen) {
      return Opacity(
          opacity: widget.opacity, child: savedChild ?? widget.child);
    }
    return savedChild = widget.child;
  }
}
