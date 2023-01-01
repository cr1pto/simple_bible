import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/models/bible.dart';

class Verse extends StatefulWidget {
  const Verse({
    super.key,
    required this.verse,
  });

  final BibleVerse verse;

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  SembastDb sembastDb = SembastDb();

  @override
  void initState() {
    // settings.init().then((value) async {
    //   setState(() {
    //     settingColor = settings.getColor();
    //     fontSize = settings.getFontSize();
    //     color = Color(settingColor);
    //   });
    // });
    super.initState();
  }

  Widget createVerseAddedPopup(BuildContext context, List<BibleVerse> versesAdded, int addedValue) {
    String json = jsonEncode(versesAdded.map((e) => e.toMap()).toList());

   return AlertDialog(
      title: const Text('Verse added'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Verse: ${widget.verse.text} - $addedValue"),
          const Text("Verses added:"),
          Text(json),
        ],
      ),
      actions: <Widget>[
        TextButton(
          // style: ButtonStyle(backgroundColor: Color.),
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.verse.text,
            style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
          fontSize: 14.0,
        )),
        onTap: () {
          sembastDb.init().then((db) async {
            int addedValue = await sembastDb.addVerse(db, widget.verse);
            List<BibleVerse> versesAdded = await sembastDb.getVerses(db);
            showDialog(context: context, builder: (buildContext) => createVerseAddedPopup(buildContext, versesAdded, addedValue));
          });
        },
        leading: Text(
          widget.verse.index.toString(),
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
            ),
        ),
      ),
    );
  }
}
