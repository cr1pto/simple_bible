import 'package:flutter/material.dart';

class Chapter extends StatelessWidget {
  const Chapter({
    super.key,
    required this.text,
    required this.number,
  });

  final String? text;
  final String? number;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text ?? ''),
      leading: Text(
        number ?? '',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
