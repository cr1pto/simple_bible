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
  // final ScrollController scrollController;
  final ItemScrollController scrollController;

  VersesScreen({super.key,
    required this.scrollController
  });

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  final BibleService bibleService = getIt();
  bool hasScrolled = false;

  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(scrollController: widget.scrollController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleState>(
      converter: (store) => store.state.bibleState,
      builder: (ctx, state) => BibleNavigationLayout(
        scrollController: widget.scrollController,
        child: ScrollablePositionedList.builder(
            physics: Platform.isIOS ? const ClampingScrollPhysics(): const AlwaysScrollableScrollPhysics(),

            itemScrollController: widget.scrollController,
          itemCount: state.currentChapter.verses.length,
          itemBuilder: (context, i) {
            Future.delayed(Duration(milliseconds: 500)).then((value)  {
              if(widget.scrollController.isAttached && !hasScrolled) {
                widget.scrollController.jumpTo(index: state.currentVerse.verseNumber - 1);
                hasScrolled = true;
              }
            });
            return Verse(verse: state.currentChapter.verses[i]);
        })
      ),
    );
  }
}
