import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:redux/redux.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final searchTextController = TextEditingController();
  final LogService logService = getIt();
  final Store<BibleAppState> store = getIt();
  final BibleService bibleService = getIt();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    searchTextController.addListener(updateSearchResults);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchTextController.dispose();
    super.dispose();
  }

  void updateSearchResults() {
    store.dispatch(UpdateSearchAction(searchTextController.text, List.empty()));
    store.dispatch(UpdateVerseScrollAction(false));
    store.dispatch(fetchLatestSearchResults);
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: GestureDetector(
        child: TextField(
          controller: searchTextController,
          autofocus: true,
          // onEditingComplete: () {
          //   FocusScopeNode currentFocus = FocusScope.of(context);
          //
          //   if (!currentFocus.hasPrimaryFocus) {
          //     currentFocus.unfocus();
          //     updateSearchResults();
          //   }
          // },
          onSubmitted: (res) {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              updateSearchResults();
            }
          },
        ),
      ),
    );
  }
}
