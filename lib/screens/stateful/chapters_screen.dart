import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class ChaptersScreen extends StatefulWidget {
  final String bookName;
  final List<BibleChapter> chapters;
  final BibleInfo bibleInfo;
  final Bible bible;

  ChaptersScreen({
    super.key,
    required this.bookName,
    required this.chapters,
    required this.bibleInfo,
    required this.bible
  });

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final Store<BibleAppState> store = getIt();
  final BibleService bibleService = getIt();

  final ItemScrollController scrollController = ItemScrollController();

  openSelectedChapter(BuildContext context, int chapterIndex) {
    setState(() {
      BibleChapter selectedChapter = widget.chapters[chapterIndex];
      BibleInfoBook selectedBookInfo = widget.bibleInfo.books.firstWhere((element) => element.name == widget.bookName);
      BibleBook book = widget.bible.books.firstWhere((element) => element.bookNumber == selectedBookInfo.bookNumber);
      store.dispatch(UpdateChapterAction(selectedChapter.chapterNumber, selectedChapter.verses));
      store.dispatch(UpdateBookAction(selectedBookInfo, book));
      store.dispatch(updateChapter);
      store.dispatch(updateBook);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChapterScreen(scrollController: scrollController),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingBack: true,
      floatingBackHero: "chapters-back",
      child: ListView.builder(
        itemCount: widget.chapters.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text(widget.chapters[i].chapterNumber.toString(),
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0,
                  )),
              onTap: () => {
                openSelectedChapter(context, i),
              },
            ),
          );
        },
      ),
    );
  }
}
