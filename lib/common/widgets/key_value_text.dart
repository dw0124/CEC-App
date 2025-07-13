import 'package:flutter/material.dart';
import 'package:induk/common/widgets/spacedLabel.dart';

class KeyValueText extends StatelessWidget {
  final double spacing;
  final String keyString;
  final String valueString;
  final double labelWidth;

  const KeyValueText({
    super.key,
    this.spacing = 8,
    required this.keyString,
    required this.valueString,
    this.labelWidth = 70,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SpacedLabel(text: keyString, width: labelWidth),
        Text(valueString),
      ],
    );
  }
}
