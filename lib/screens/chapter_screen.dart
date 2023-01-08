// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/verses_screen.dart';

@Injectable()
class ChapterScreen extends StatelessWidget {
  final String bookName;
  final BibleChapter chapter;
  final BibleInfo bibleInfo;
  final Bible bible;

  const ChapterScreen({
    super.key,
    required this.bookName,
    required this.chapter, required this.bibleInfo, required this.bible,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingBack: true,
      floatingBackHero: "chapter-back",
      child: VersesScreen(
        title: '$bookName - ${chapter.chapterNumber}',
        verses: chapter.verses,
        bible: bible,
        bibleInfo: bibleInfo
      ),
    );
  }
}
