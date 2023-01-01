import 'package:flutter/material.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/screens/bible_screen.dart';
import 'package:simple_bible/screens/memorize_scripture_screen.dart';
import 'package:simple_bible/screens/recent_activity_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

class HomeOptionsScreen extends StatefulWidget {
  final BibleService bibleService = BibleService();

  HomeOptionsScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeOptionsScreenState createState() => _HomeOptionsScreenState();
}

class _HomeOptionsScreenState extends State<HomeOptionsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  SembastDb sembastDb = SembastDb();
  Color color = const Color(0x00000000);

  @override
  void initState() {
    settings.init().then((value) async {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        color = Color(settingColor);
      });
    });
    super.initState();
  }

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
                  MaterialPageRoute(builder: (context) => const RecentActivityScreen()),
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
        ],
      ),
    );
  }
}
