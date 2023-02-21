import 'package:flutter/material.dart';
import 'package:simple_bible/components/verse.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';

class Chapter extends StatelessWidget {
  const Chapter({
    super.key,
    required this.bookName,
    required this.chapter,
  });

  final String bookName;
  final BibleChapter chapter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chapter.verses.length,
      itemBuilder: (context, i) {
        return Verse(verse: chapter.verses[i]);
      },
    );
  }
}
