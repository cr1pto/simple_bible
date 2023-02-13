import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

class VerseSearch extends StatefulWidget {
  final BibleVerse verse;

  VerseSearch({super.key, required this.verse});

  @override
  State<VerseSearch> createState() => _VerseSearchState();
}

class _VerseSearchState extends State<VerseSearch> {
  final BibleService bibleService = getIt();
  final Store<BibleAppState> store = getIt();
  final ItemScrollController scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleAppState>(
      converter: (store) => store.state,
      builder: (ctx, state) => Card(
        child: ListTile(
          title: Text(widget.verse.text,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: state.settingsState.fontSize,
              )),
          onTap: () async {
            BibleBook book = state.bibleState.bibleVm.bible.books[widget.verse.bookNumber - 1];
            BibleInfoBook bookInfo = state.bibleState.bibleVm.bibleInfo.books[widget.verse.bookNumber - 1];
            BibleChapter selectedChapter = state.bibleState.bibleVm.bible.books[widget.verse.bookNumber - 1].chapters[widget.verse.chapterNumber - 1];
            store.dispatch(UpdateChapterAction(selectedChapter.chapterNumber, selectedChapter.verses));
            store.dispatch(UpdateBookAction(bookInfo, book));
            store.dispatch(updateChapter);
            store.dispatch(updateBook);
            store.dispatch(UpdateCurrentVerseAction(widget.verse));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChapterScreen(),
              ),
            );
          },
          subtitle: Text(
            "${bibleService.getBookNameByBookNumber(state.bibleState.bibleVm.bibleInfo, widget.verse.bookNumber)} ${widget.verse.chapterNumber}:${widget.verse.verseNumber}",
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
}
