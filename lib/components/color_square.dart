import 'package:flutter/material.dart';

class ColorSquare extends StatelessWidget {
  const ColorSquare({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: color,
      ),
    );
  }
}
