import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

@Injectable()
class MemorizeScriptureScreen extends StatefulWidget {

  MemorizeScriptureScreen({Key? key}) : super(key: key);

  @override
  State<MemorizeScriptureScreen> createState() => _MemorizeScriptureScreenState();
}

class _MemorizeScriptureScreenState extends State<MemorizeScriptureScreen> {
  final SPSettings settings = getIt();
  final SembastDb sembastDb = getIt();
  final BibleService bibleService = getIt();
  final Store<BibleAppState> store = getIt();
  final double fontSize = 20.0;

  BibleVerse randomBibleVerse = BibleVerse(0, "", 0, 0);

  // @override
  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Memorize Random Scripture',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: StoreProvider<BibleAppState>(
        store: store,
        child: buildRandomScripture(context),
      )
      );
  }

  Widget getRandomScripture() {
    BibleVm bibleVm = store.state.bibleState.bibleVm;
    BibleVerse verse = bibleService.getRandomVerse(bibleVm.bibleInfo, bibleVm.bible);
    BibleInfoBook bookInfo = bibleService.getBookInfoFromBookNumberIndex(bibleVm.bible, bibleVm.bibleInfo, verse.bookNumber - 1);
    BibleChapter bibleChapter = bibleService.getChapterInfoFromNumberIndex(bibleVm.bible, bookInfo, verse.chapterNumber - 1);

    return StoreConnector<BibleAppState, BibleAppState>(
      converter: (store) => store.state,
      builder: (ctx, state) => Card(
        child: ListTile(
          title: Text(verse.text,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: state.settingsState.fontSize,
              )),
          onTap: () async {
            BibleBook book = state.bibleState.bibleVm.bible.books[verse.bookNumber - 1];
            store.dispatch(UpdateChapterAction(bibleChapter.chapterNumber, bibleChapter.verses));
            store.dispatch(UpdateBookAction(bookInfo, book));
            store.dispatch(updateChapter);
            store.dispatch(updateBook);
            store.dispatch(UpdateCurrentVerseAction(verse));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChapterScreen(),
              ),
            );
          },
          subtitle: Text(
            "${bibleService.getBookNameByBookNumber(state.bibleState.bibleVm.bibleInfo, verse.bookNumber)} ${verse.chapterNumber}:${verse.verseNumber}",
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
              leadingDistribution: TextLeadingDistribution.even,
              fontSize: 16.0,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }

  Widget buildRandomScripture(BuildContext context) {
    return getRandomScripture();
  }
}
