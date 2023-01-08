import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bible_info_book.dart';
import 'package:simple_bible/models/bible_verse.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class MemorizeScriptureScreen extends StatefulWidget {
  final SPSettings settings = getIt();
  final SembastDb sembastDb = getIt();
  final BibleService bibleService = getIt();
  MemorizeScriptureScreen({Key? key}) : super(key: key);

  @override
  _MemorizeScriptureScreenState createState() =>
      _MemorizeScriptureScreenState();
}

class _MemorizeScriptureScreenState extends State<MemorizeScriptureScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  Color color = const Color(0x00000000);
  BibleVerse randomBibleVerse = BibleVerse(0, "", 0, 0);
  late BibleInfo bibleInfo;
  late Bible bible;

  @override
  void initState() {
    widget.settings.init().then((value) async {
      setState(() {
        settingColor = widget.settings.getColor();
        fontSize = widget.settings.getFontSize();
        color = Color(settingColor);
      });
    });
    super.initState();
  }

  openSelectedChapter(BuildContext context, String bookName, BibleChapter chapter) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChapterScreen(
          bookName: bookName,
          chapter: chapter,
          bibleInfo: bibleInfo,
          bible: bible,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Memorize Random Scripture',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          if (state is BibleLoaded) {
            bibleInfo = state.info;
            bible = state.bible;
            BibleVerse verse = widget.bibleService.getRandomVerse(bibleInfo, bible);
            BibleInfoBook bookInfo = widget.bibleService.getBookInfoFromBookNumberIndex(bible, bibleInfo, verse.bookNumber - 1);
            BibleChapter bibleChapter = widget.bibleService.getChapterInfoFromNumberIndex(bible, bookInfo, verse.chapterNumber - 1);
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
          return Container();
        })
      );
  }
}
