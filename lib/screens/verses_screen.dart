// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';

import '../components/verse.dart';

class VersesScreen extends StatelessWidget {
  const VersesScreen({super.key, required this.title, required this.verses});

  final String title;
  final List<BibleVerse> verses;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: title,
      child: ListView.builder(
        itemCount: verses.length,
        itemBuilder: (context, i) {
          return Verse(verse: verses[i]);
        },
      ),
    );
  }
}
