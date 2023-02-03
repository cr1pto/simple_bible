import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/components/verse.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/bible_navigation_layout.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class VersesScreen extends StatelessWidget {
  final String title;
  final List<BibleVerse> verses;
  final BibleService bibleService = getIt();
  final BibleInfo bibleInfo;
  final Bible bible;

  VersesScreen({super.key, required this.title, required this.verses, required this.bibleInfo, required this.bible});

  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleState>(
      converter: (store) => store.state.bibleState,
      builder: (ctx, state) => BibleNavigationLayout(
        title: title,
        child: ListView.builder(
          itemCount: state.currentChapter.verses.length,
          itemBuilder: (context, i) {
            return Verse(verse: verses[i]);
        })
      ),
    );
  }
}
