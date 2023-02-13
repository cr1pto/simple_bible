import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/search_state.dart';
import 'package:simple_bible/screens/stateful/search_form.dart';
import 'package:simple_bible/screens/stateless/verse_search.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final BibleService bibleService = getIt();
  final Store<BibleAppState> store = getIt();

  @override
  initState() {
    setState(() {
      store.dispatch(UpdateVerseScrollAction(false));
      store.dispatch(UpdateSearchAction("", List.empty()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, SearchState>(
      converter: (store) => store.state.searchState,
      builder: (ctx, state) => MainLayout(
        title: 'Home',
        floatingBack: true,
        floatingBackHero: "home-back",
        child: ListView(
          children: getAdditionalWidgets(state)
        ),
      ),
    );
  }

  List<Widget> buildChildrenFromVerses(List<BibleVerse> verses) {
    Iterable<Widget> verseWidgets = verses.map((verse) {
      Widget vrs = VerseSearch(verse: verse);

      return vrs;
    });
    return verseWidgets.toList();
  }

  List<Widget> getAdditionalWidgets(SearchState searchState) {
    List<Widget> widgets = List<Widget>.empty(growable: true);
    const search = SearchForm();
    List<Widget> searchResults = buildChildrenFromVerses(searchState.verses);

    Widget searchResultsCard = ListTile(
      title: const Text("Tap here to search. Long press to clear...",
      style: TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w300,
        fontSize: 14.0,
      )),
      onTap: () {
        setState(() {
          store.dispatch(fetchLatestSearchResults);
        });
      },
      onLongPress: () {
        store.dispatch(UpdateSearchAction("", List.empty()));
      },
    );
    widgets.add(search);
    widgets.add(searchResultsCard);
    widgets.addAll(searchResults);
    return widgets;
  }
}
