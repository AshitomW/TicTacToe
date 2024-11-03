import "package:flutter/material.dart";

class TextWidget extends StatelessWidget {
  final List<Shadow> shadows;
  final String text;
  final double fontSize;
  final FontWeight weight;
  const TextWidget(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.weight,
      required this.shadows});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: weight,
        fontSize: fontSize,
        shadows: shadows,
      ),
    );
  }
}
