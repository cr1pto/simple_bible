import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/verses_screen.dart';

@Injectable()
class ChapterScreen extends StatelessWidget {
  ChapterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleAppState>(
      converter: (store) => store.state,
      builder: (ctx, state) => MainLayout(
        floatingBack: true,
        floatingBackHero: "chapter-back",
        child: VersesScreen(
          title: '${state.chapterState.bookInfo.name} ${state.chapterState.chapter.chapterNumber}',
          verses: state.chapterState.chapter.verses,
          bible: state.bibleState.bibleVm.bible,
          bibleInfo: state.bibleState.bibleVm.bibleInfo
        ),
      ),
    );
  }
}
