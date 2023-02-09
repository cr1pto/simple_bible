import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';

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
  SembastDb sembastDb = getIt();
  SPSettings settings = getIt();
  Database db = getIt();
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  late Color color;


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

  Widget createVerseAddedPopup(BuildContext context, List<BibleVerse> versesAdded, int addedValue) {
   return AlertDialog(
      title: const Text('Verse added'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Verse: ${widget.verse.text} - $addedValue"),
          const Text("Verse added:"),
          Text("Added verse"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
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
            style: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
          fontSize: fontSize,
        )),
        onTap: () async {
          int addedValue = await sembastDb.addVerse(db, widget.verse);
          List<BibleVerse> versesAdded = await sembastDb.getVerses(db);
          showDialog(context: context, builder: (buildContext) => createVerseAddedPopup(buildContext, versesAdded, addedValue));
        },
        leading: Text(
          widget.verse.verseNumber.toString(),
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
