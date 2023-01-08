import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/bible_screen.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/shared/menu_bar.dart';

@Injectable()
class BibleNavigationLayout extends StatefulWidget {
  final BibleChapter chapter;
  final BibleChapter previousChapter;
  final BibleChapter nextChapter;
  final Bible bible;
  final BibleInfo bibleInfo;
  final Widget child;
  final String? title;
  final bool drawer;
  final bool floatingBack;
  final String? floatingBackHero;
  final SPSettings settings = getIt();
  final BibleService bibleService = getIt();
  final SembastDb sembastDb = getIt();

  BibleNavigationLayout({
    super.key,
    required this.chapter,
    required this.child,
    this.title,
    this.drawer = true,
    this.floatingBack = false,
    this.floatingBackHero, required this.previousChapter, required this.nextChapter, required this.bible, required this.bibleInfo,
  });

  @override
  State<BibleNavigationLayout> createState() => _BibleNavigationLayoutState();
}

class _BibleNavigationLayoutState extends State<BibleNavigationLayout> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;

  @override
  void initState() {
    widget.settings.init().then((value) async {
      setState(() {
        settingColor = widget.settings.getColor();
        fontSize = widget.settings.getFontSize();
      });
    });
    super.initState();
  }

  Widget createBibleNavigation(Bible bible, BibleInfo bibleInfo) {
    return Scaffold(
      appBar: widget.title != null
          ? AppBar(
        backgroundColor: Color(settingColor),
        title: Text(widget.title!),
      )
          : null,
      drawer: MenuDrawer(
        color: Color(settingColor),
        fontSize: fontSize,
      ),
      bottomNavigationBar: widget.title != null ? BottomAppBar(
        color: Color(settingColor),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                tooltip: 'Bible',
                icon: const Icon(Icons.book_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (routeContext) => BibleScreen()));
                },
              ),
              // if (centerLocations.contains(fabLocation)) const Spacer(),
              IconButton(
                tooltip: 'Previous Chapter',
                icon: const Icon(Icons.arrow_circle_left),
                onPressed: () {
                  // BibleChapter chapter = widget.bibleService.getNextChapterFromVerse(bible, bibleInfo, widget.)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (routeContext) => ChapterScreen(bible: widget.bible, bibleInfo: widget.bibleInfo, chapter: widget.previousChapter, bookName: "TBD")));
                },
              ),
              IconButton(
                tooltip: 'Next Chapter',
                icon: const Icon(Icons.arrow_circle_right),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (routeContext) => ChapterScreen(bible: widget.bible, bibleInfo: widget.bibleInfo, chapter: widget.nextChapter, bookName: "TBD")));
                },
              ),
            ],
          ),
        ),
      ) : null,
      body: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(
            builder: (context, state) {
              if (state is BibleLoaded) {
                return createBibleNavigation(state.bible, state.info);
              }
              return Container();
            });
  }
}
