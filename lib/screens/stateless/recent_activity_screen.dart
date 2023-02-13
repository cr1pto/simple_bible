import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/components/recent_verse.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';

@Injectable()
class RecentActivityScreen extends StatefulWidget {
  RecentActivityScreen({Key? key}) : super(key: key);

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  List<BibleVerse> verses = List.empty();

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
          onPressed: () {

          },
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
            if(i >= verses.length - 1) {
              return SizedBox(
                  height: 200,
                  child: RecentVerse(verse: verses[i]));
            }
            return RecentVerse(verse: verses[i]);
          },
        ),
      ),
    );
  }
}