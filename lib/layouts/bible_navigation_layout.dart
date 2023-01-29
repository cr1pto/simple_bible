import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/redux/state/settings_state.dart';
import 'package:simple_bible/screens/stateless/bible_screen.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/shared/menu_bar.dart';

@Injectable()
class BibleNavigationLayout extends StatelessWidget {
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

  BibleNavigationLayout({
    super.key,
    required this.chapter,
    required this.child,
    this.title,
    this.drawer = true,
    this.floatingBack = false,
    this.floatingBackHero,
    required this.previousChapter,
    required this.nextChapter,
    required this.bible,
    required this.bibleInfo,
  });

  final SPSettings settings = getIt();
  final BibleService bibleService = getIt();
  final SembastDb sembastDb = getIt();

  Widget createBibleNavigation(Bible bible, BibleInfo bibleInfo, BuildContext context) {
    return StoreConnector<SettingsState, SettingsState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Scaffold(
            appBar: title != null
                ? AppBar(
              backgroundColor: Color(state.settingColor),
              title: Text(title!),
            )
                : null,
            drawer: MenuDrawer(),
            bottomNavigationBar: title != null ? BottomAppBar(
              color: Color(state.settingColor),
              child: IconTheme(
                data: IconThemeData(color: Theme
                    .of(context)
                    .colorScheme
                    .onPrimary),
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
                                builder: (routeContext) =>
                                //TODO: update to get previous chapter via redux
                                    ChapterScreen()));
                      },
                    ),
                    IconButton(
                      tooltip: 'Next Chapter',
                      icon: const Icon(Icons.arrow_circle_right),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (routeContext) =>
                                    ChapterScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ) : null,
            body: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(
            builder: (context, state) {
              if (state is BibleLoaded) {
                return createBibleNavigation(state.bible, state.info, context);
              }
              return Container();
            });
  }
}
