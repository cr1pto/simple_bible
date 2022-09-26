import 'package:flutter/material.dart';

import '../models/bible.dart';

class Verse extends StatelessWidget {
  const Verse({
    super.key,
    required this.verse,
  });

  final BibleVerse verse;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(verse.text),
      leading: Text(
        verse.index.toString(),
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
