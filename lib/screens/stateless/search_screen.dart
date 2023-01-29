import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/screens/stateful/search_form.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final BibleService bibleService = getIt();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: ListView(
        children: [
          const SearchForm(),
          Card(
            child: ListTile(
              title: const Text("Search Results...",
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
            ),
          ),
        ],
      ),
    );
  }
}
