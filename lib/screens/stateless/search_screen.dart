import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateful/search_form.dart';
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
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: ListView(
        children: getAdditionalWidgets()
      ),
    );
  }

  List<Widget> getAdditionalWidgets() {
    List<Widget> widgets = List<Widget>.empty(growable: true);
    const search = SearchForm();
    Widget searchResultsCard = ListTile(
      title: Text("Search Results...",
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
          )),
      onTap: () {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => const RecentActivityScreen()),
        // );
      },
    );
    widgets.add(search);
    widgets.add(searchResultsCard);
    widgets.add(Text(""));

    return widgets;
  }
}
