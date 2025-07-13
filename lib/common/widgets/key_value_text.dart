import 'package:flutter/material.dart';
import 'package:induk/common/widgets/spacedLabel.dart';

class KeyValueText extends StatelessWidget {
  final double spacing;
  final String keyString;
  final TextStyle? keyStyle;
  final String valueString;
  final TextStyle? valueStyle;
  final double labelWidth;

  const KeyValueText({
    super.key,
    this.spacing = 8,
    required this.keyString,
    this.keyStyle,
    required this.valueString,
    this.valueStyle,
    this.labelWidth = 70,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SpacedLabel(text: keyString, width: labelWidth, style: keyStyle),
        Text(
            valueString,
          style: valueStyle,
        ),
      ],
    );
  }
}
