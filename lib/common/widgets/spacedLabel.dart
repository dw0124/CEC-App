import 'package:flutter/material.dart';

class SpacedLabel extends StatelessWidget {
  final String text;
  final double width;
  final TextStyle? style;

  const SpacedLabel({
    super.key,
    required this.text,
    required this.width,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final chars = text.characters.toList();
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: chars.asMap().entries.map((entry) {
          final i = entry.key;
          final char = entry.value;
          return Text(
            i == chars.length - 1 ? '$char:' : char,
            style: style ?? TextStyle(fontWeight: FontWeight.w600),
          );
        }).toList(),
      ),
    );
  }
}