import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

@Injectable()
class MemorizeScriptureScreen extends StatelessWidget {
  final SPSettings settings = getIt();
  final SembastDb sembastDb = getIt();
  final BibleService bibleService = getIt();
  final Store<BibleAppState> store = getIt();
  BibleVerse randomBibleVerse = BibleVerse(0, "", 0, 0);

  MemorizeScriptureScreen({Key? key}) : super(key: key);

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
        child: getRandomScripture(context),
      )
      );
  }

  Widget getRandomScripture(BuildContext context) {
    BibleVm bibleVm = store.state.bibleState!.bibleVm ?? BibleVm.initial();
    BibleVerse verse = bibleService.getRandomVerse(bibleVm.bibleInfo, bibleVm.bible);
    BibleInfoBook bookInfo = bibleService.getBookInfoFromBookNumberIndex(bibleVm.bible, bibleVm.bibleInfo, verse.bookNumber - 1);
    BibleChapter bibleChapter = bibleService.getChapterInfoFromNumberIndex(bibleVm.bible, bookInfo, verse.chapterNumber - 1);
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
}
