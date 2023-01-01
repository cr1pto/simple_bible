import 'package:flutter/material.dart';
import 'package:simple_bible/components/recent_verse.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';

class RecentActivityScreen extends StatefulWidget {
  const RecentActivityScreen({Key? key}) : super(key: key);

  @override
  _RecentActivityScreenState createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  SembastDb sembastDb = SembastDb();
  Color color = const Color(0x00000000);
  List<BibleVerse> verses = List.empty();

  @override
  void initState() {
    sembastDb.init().then((db) async {
      List<BibleVerse> recentVerses = await sembastDb.getVerses(db);
      setState(() {
        verses = recentVerses;
      });
    });
    settings.init().then((value) async {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        color = Color(settingColor);
      });
    });
    super.initState();
  }

  Widget confirmDeleteVersePopup(BuildContext context) {
    return AlertDialog(
      title: const Text('Verses'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Clear all recent verses?"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          // style: ButtonStyle(backgroundColor: Color.),
          onPressed: () {
            sembastDb.init().then((db) async {
              await sembastDb.clearAllVerses(db);
              setState(() {
                verses = [];
                Navigator.of(context).pop();
              });
            });
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Clear All'),
        ),
        TextButton(
          // style: ButtonStyle(backgroundColor: Color.),
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Recent Activity',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(Colors.red.value),
          heroTag: "main-layout-back",
          onPressed: () {
            showDialog(context: context, builder: (buildContext) => confirmDeleteVersePopup(buildContext));
          },
          child: const Icon(Icons.delete_forever_sharp)
        ),
        body: ListView.builder(
          itemCount: verses.length,
          itemBuilder: (context, i) {
            return RecentVerse(verse: verses[i]);
          },
        ),
      ),
    );
  }
}