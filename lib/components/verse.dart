import 'package:flutter/material.dart';

class Verse extends StatelessWidget {
  const Verse({
    super.key,
    required this.number,
    required this.text,
  });

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Text(
        number,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
