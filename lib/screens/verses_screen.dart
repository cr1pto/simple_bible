// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/bible_navigation_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bible_info_book.dart';
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
    return BibleNavigationLayout(
      title: widget.title,
      chapter: widget.bibleService.getChapterFromVerse(widget.bible, widget.bibleInfo, widget.verses[0]),
      child: BlocBuilder<BibleBloc, BibleState>(
          builder: (context, state) {
            if (state is BibleLoaded) {
              BibleVerse verse = widget.bibleService.getRandomVerse(widget.bibleInfo, widget.bible);
              BibleInfoBook bookInfo = widget.bibleService.getBookInfoFromBookNumberIndex(widget.bible, widget.bibleInfo, verse.bookNumber - 1);
              BibleChapter bibleChapter = widget.bibleService.getChapterInfoFromNumberIndex(widget.bible, bookInfo, verse.chapterNumber - 1);
              return Card(
                child: ListTile(
                  title: Text("${bookInfo.name} ${verse.chapterNumber}:${verse.verseNumber} - ${verse.text}",
                      style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                      )),
                  onTap: () => {
                    openSelectedChapter(context, bookInfo.name, bibleChapter),
                  },
                ),
              );
            }
            return Container();
          })
    );
  }
}
