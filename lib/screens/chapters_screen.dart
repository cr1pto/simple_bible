// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

@Injectable()
class ChaptersScreen extends StatelessWidget {
  final String bookName;
  final List<BibleChapter> chapters;
  final BibleInfo bibleInfo;
  final Bible bible;

  const ChaptersScreen({
    super.key,
    required this.bookName,
    required this.chapters, required this.bibleInfo, required this.bible
  });

  openSelectedChapter(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(
          bookName: bookName,
          chapter: chapters[index],
          bible: bible,
          bibleInfo: bibleInfo
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingBack: true,
      floatingBackHero: "chapters-back",
      child: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text(chapters[i].chapterNumber.toString(),
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0,
                  )),
              onTap: () => {
                openSelectedChapter(context, i),
              },
            ),
          );
        },
      ),
    );
  }
}
