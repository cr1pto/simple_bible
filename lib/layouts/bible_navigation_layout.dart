import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/bible_screen.dart';
import 'package:simple_bible/screens/stateless/chapter_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/shared/menu_bar.dart';

@Injectable()
class BibleNavigationLayout extends StatelessWidget {
  final Widget child;
  final ItemScrollController scrollController;

  BibleNavigationLayout({
    super.key,
    required this.child,
    required this.scrollController
  });

  final SPSettings settings = getIt();
  final BibleService bibleService = getIt();
  final SembastDb sembastDb = getIt();
  final Store<BibleAppState> store = getIt();

  Widget createBibleNavigation(BuildContext context) {
    return StoreProvider<BibleAppState>(
      store: store,
      child: StoreConnector<BibleAppState, BibleAppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(state.settingsState.settingColor),
                title: Text('${state.bibleState.bibleInfoBook.name} ${state.bibleState.currentChapter.chapterNumber}'),
              ),
              drawer: MenuDrawer(),
              bottomNavigationBar: BottomAppBar(
                color: Color(state.settingsState.settingColor),
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
                        icon: Icon(Icons.book_outlined,
                            color: Color(state.settingsState.settingColor)
                        ),
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
                        icon: Icon(Icons.arrow_circle_left,
                            color: Color(state.settingsState.settingColor)
                        ),
                        onPressed: () {
                          store.dispatch(updateToPreviousChapter);
                          store.dispatch(updateBook);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (routeContext) =>
                                  //TODO: update to get previous chapter via redux
                                      ChapterScreen(scrollController: scrollController,)));
                        },
                      ),
                      IconButton(
                        tooltip: 'Next Chapter',
                        icon: Icon(Icons.arrow_circle_right,
                            color: Color(state.settingsState.settingColor)
                        ),
                        onPressed: () {
                          store.dispatch(updateToNextChapter);
                          store.dispatch(updateBook);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (routeContext) =>
                                      ChapterScreen(scrollController: scrollController,)));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: child,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createBibleNavigation(context);
  }
}
