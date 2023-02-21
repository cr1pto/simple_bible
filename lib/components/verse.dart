import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sembast/sembast.dart';
import 'package:simple_bible/components/verse_text.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';

class Verse extends StatefulWidget {
  Verse({
    super.key,
    required this.verse,
  });

  final BibleVerse verse;

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  SPSettings settings = getIt();
  Store<BibleAppState> store = getIt();
  bool shouldSelectVerse = false;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  late Color color;


  @override
  void initState() {
    settings.init().then((value) async {
      settingColor = settings.getColor();
      fontSize = settings.getFontSize();
      color = Color(settingColor);
      setState(() {
        // shouldSelectVerse = widget.isVerseSelected;
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
    return StoreConnector<BibleAppState, BibleState>(
      converter: (storeConnector) => storeConnector.state.bibleState,
      builder: (ctx, state) => VerseText(
          fontSize: fontSize,
          verseText: widget.verse.text,
          verseNumber: widget.verse.verseNumber,
          selected: shouldSelectVerse,
          onTap: (key) {
            setState(() {
              shouldSelectVerse = !shouldSelectVerse;
            });
          }
      ),
    );
  }
}
