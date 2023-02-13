import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/components/verse.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/bible_navigation_layout.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
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
  final Store<BibleAppState> store = getIt();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final List<Verse> selectedVerses = List.empty(growable: true);
  bool isVerseSelected = false;

  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(),
      ),
    );
  }

  @override
  initState() {
    // setState(() {
    //   store.dispatch(UpdateVerseScrollAction(false));
    // });
    super.initState();
  }

  Verse createVerse(BibleVerse verse) {
    Verse addedVerse = Verse(verse: verse, onVerseAdded: (key) async => await onVerseTap(ValueKey<int>(verse.verseNumber)), isVerseSelected: isVerseSelected);
    selectedVerses.add(addedVerse);
    return addedVerse;
  }

  Future onVerseTap(ValueKey<int> key) async {
    // int addedValue = await sembastDb.addVerse(db, widget.verse);
    // List<BibleVerse> versesAdded = await sembastDb.getVerses(db);
    // showDialog(context: ctx, builder: (buildContext) => createVerseAddedPopup(buildContext, versesAdded, addedValue));
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      int verseIndex = key.value - 1;
      var vrs = selectedVerses[verseIndex];
      // selectedVerses[verseNumber - 1].isVerseSelected = !selectedVerses[verseNumber - 1].isVerseSelected;

      // selectedVerse = verseAdded;
      // isVerseSelected
      // value
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleAppState>(
      converter: (store) => store.state,
      builder: (ctx, state) => BibleNavigationLayout(
        child: ScrollablePositionedList.builder(
          initialScrollIndex: 0,
          physics: Platform.isIOS
              ? const ClampingScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          itemScrollController: _itemScrollController,
          itemCount: state.bibleState.currentChapter.verses.length,
          itemBuilder: (context, i) {
            Future.delayed(Duration(milliseconds: 500)).then((value)  {
              if(_itemScrollController.isAttached && !state.chapterState.hasJumpedToVerse) {
                var index = state.bibleState.currentVerse.verseNumber <= 0 ? 0 : state.bibleState.currentVerse.verseNumber - 1;
                _itemScrollController.jumpTo(index: index);
                store.dispatch(UpdateVerseScrollAction(true));
              }
            });
            var vrs = createVerse(state.bibleState.currentChapter.verses[i]);
            return vrs;
        })
      ),
    );
  }
}
