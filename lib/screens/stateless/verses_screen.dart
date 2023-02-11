import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/components/verse.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/bible_navigation_layout.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class VersesScreen extends StatefulWidget {
  VersesScreen({super.key});

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  final BibleService bibleService = getIt();
  bool hasJumped = false;
  final ItemScrollController _itemScrollController = ItemScrollController();

  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(),
      ),
    );
  }

  @override
  initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleState>(
      converter: (store) => store.state.bibleState,
      builder: (ctx, state) => BibleNavigationLayout(
        child: ScrollablePositionedList.builder(
          initialScrollIndex: 0,
          physics: Platform.isIOS
              ? const ClampingScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          itemScrollController: _itemScrollController,
          itemCount: state.currentChapter.verses.length,
          itemBuilder: (context, i) {
            Future.delayed(Duration(milliseconds: 500)).then((value)  {
              if(_itemScrollController.isAttached && !hasJumped) {
                var index = state.currentVerse.verseNumber <= 0 ? 0 : state.currentVerse.verseNumber - 1;
                _itemScrollController.jumpTo(index: index);
                hasJumped = true;
              }
            });
            return Verse(verse: state.currentChapter.verses[i]);
        })
      ),
    );
  }
}
