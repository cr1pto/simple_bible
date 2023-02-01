import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/screens/stateless/bible_screen.dart';
import 'package:simple_bible/screens/stateless/memorize_scripture_screen.dart';
import 'package:simple_bible/screens/stateless/recent_activity_screen.dart';
import 'package:simple_bible/screens/stateless/search_screen.dart';

@Injectable()
class HomeOptionsScreen extends StatelessWidget {
  HomeOptionsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text("Recent Activity",
                  style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              )),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RecentActivityScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text("Read Bible",
                  style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontSize: 14.0,
              )),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BibleScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                "Memorize Scripture",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MemorizeScriptureScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                "Search Scripture",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
