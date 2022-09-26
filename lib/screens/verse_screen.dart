// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';

import '../components/verse.dart';

class VerseScreen extends StatelessWidget {
  const VerseScreen({super.key, required this.verse});

  final BibleVerse verse;

  @override
  Widget build(BuildContext context) {
    return Verse(
      number: verse.index.toString(),
      text: verse.text,
    );
  }
}
