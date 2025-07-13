import 'package:flutter/material.dart';

class SpacedLabel extends StatelessWidget {
  final String text;
  final double width;

  const SpacedLabel({
    super.key,
    required this.text,
    required this.width,
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
            style: const TextStyle(fontWeight: FontWeight.w600),
          );
        }).toList(),
      ),
    );
  }
}