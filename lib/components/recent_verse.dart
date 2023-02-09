import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

@Injectable()
class RecentVerse extends StatefulWidget {
  final BibleVerse verse;

  RecentVerse({
    super.key,
    required this.verse,
  });

  @override
  State<RecentVerse> createState() => _RecentVerseState();
}

class _RecentVerseState extends State<RecentVerse> {
  final BibleService bibleService = getIt();
  final LogService logService = getIt();
  final Store<BibleAppState> store = getIt();
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<BibleAppState>(
      store: store,
      child: getRecentVerse(context),
    );
  }

  getRecentVerse(BuildContext context) {
    BibleVm bibleVm = store.state.bibleState.bibleVm;
    BibleInfoBook bookInfo = bibleService.getBookInfoFromBookNumberIndex(bibleVm.bible, bibleVm.bibleInfo, widget.verse.bookNumber - 1);
    BibleInfoBook verseInfoBook = bibleService.getBookInfoFromBookNumberIndex(bibleVm.bible, bibleVm.bibleInfo, widget.verse.bookNumber - 1);
    BibleChapter chapter = bibleService.getChapterInfoFromNumberIndex(bibleVm.bible, verseInfoBook, widget.verse.chapterNumber - 1);
    return Card(
      child: ListTile(
        onTap: () {
          logService.info("bookInfo: index ${bookInfo.bookNumber} - ${bookInfo.chapterCount} - ${bookInfo.name} - ${bookInfo.abbr}");
          logService.info("verseInfoBook: index ${verseInfoBook.bookNumber} - ${verseInfoBook.chapterCount} - ${verseInfoBook.name} - ${verseInfoBook.abbr}");
          logService.info("chapter: index ${chapter.chapterNumber} - chapter verse index: ${chapter.verses[0].verseNumber} - chapter number: ${chapter.verses[0].chapterNumber} - bookNumber: ${chapter.verses[0].bookNumber} - verse text: ${chapter.verses[0].text}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (routeContext) => ChapterScreen(scrollController: _scrollController)));
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
}
