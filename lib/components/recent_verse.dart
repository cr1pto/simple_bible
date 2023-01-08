import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bible_info_book.dart';
import 'package:simple_bible/models/bible_verse.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

@Injectable()
class RecentVerse extends StatefulWidget {
  final BibleVerse verse;
  final BibleService bibleService = getIt();
  final LogService logService = getIt();

  RecentVerse({
    super.key,
    required this.verse,
  });

  @override
  State<RecentVerse> createState() => _RecentVerseState();
}

class _RecentVerseState extends State<RecentVerse> {

  @override
  void initState() {
    // settings.init().then((value) async {
    //   setState(() {
    //     settingColor = settings.getColor();
    //     fontSize = settings.getFontSize();
    //     color = Color(settingColor);
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(
      builder: (context, state) {
        if (state is BibleLoaded) {
          // return BooksScreen(books: state.info.books, bible: state.bible);
          BibleInfoBook bookInfo = widget.bibleService.getBookInfoFromBookNumberIndex(state.bible, state.info, widget.verse.bookNumber - 1);
          BibleInfoBook verseInfoBook = widget.bibleService.getBookInfoFromBookNumberIndex(state.bible, state.info, widget.verse.bookNumber - 1);
          BibleChapter chapter = widget.bibleService.getChapterInfoFromNumberIndex(state.bible, verseInfoBook, widget.verse.chapterNumber - 1);
          return Card(
            child: ListTile(
              onTap: () {
                widget.logService.info("bookInfo: index ${bookInfo.bookNumber} - ${bookInfo.chapterCount} - ${bookInfo.name} - ${bookInfo.abbr}");
                widget.logService.info("verseInfoBook: index ${verseInfoBook.bookNumber} - ${verseInfoBook.chapterCount} - ${verseInfoBook.name} - ${verseInfoBook.abbr}");
                widget.logService.info("chapter: index ${chapter.chapterNumber} - chapter verse index: ${chapter.verses[0].verseNumber} - chapter number: ${chapter.verses[0].chapterNumber} - bookNumber: ${chapter.verses[0].bookNumber} - verse text: ${chapter.verses[0].text}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (routeContext) => ChapterScreen(bookName: verseInfoBook.name, chapter: chapter, bible: state.bible, bibleInfo: state.info,)));
              },
              title: Text(
                  "${bookInfo.name} ${widget.verse.chapterNumber}:${widget.verse.verseNumber} - ${widget.verse.text}",
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                )),
            ),
          );
        }
        return Container();
      },
    );
  }
}
