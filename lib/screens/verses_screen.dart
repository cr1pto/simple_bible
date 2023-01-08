// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/components/verse.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/bible_navigation_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bible_verse.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class VersesScreen extends StatefulWidget {
  final String title;
  final List<BibleVerse> verses;
  final BibleService bibleService = getIt();
  final BibleInfo bibleInfo;
  final Bible bible;

  VersesScreen({super.key, required this.title, required this.verses, required this.bibleInfo, required this.bible});

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {

  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(
          bookName: bookName,
          chapter: chapter,
          bible: widget.bible,
          bibleInfo: widget.bibleInfo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BibleChapter chapter = widget.bibleService.getChapterFromVerse(widget.bible, widget.bibleInfo, widget.verses[0]);
    return BibleNavigationLayout(
      title: widget.title,
      chapter: chapter,
      child: ListView.builder(
        itemCount: chapter.verses.length,
        itemBuilder: (context, i) {
          return Verse(verse: widget.verses[i]);
      })
    );
  }
}
