import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/books_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

import '../data/sembast_db.dart';
import '../data/shared_prefs.dart';
import '../shared/menu_bar.dart';

class BibleScreen extends StatefulWidget {
  final String widgetName = 'Bible';
  final BibleService bibleService = BibleService();
  @override
  _BibleScreenState createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  SembastDb sembastDb = SembastDb();
  Bible? bible;
  String bibleText = '';
  late Widget booksWidget;

  @override
  void initState() {
    settings.init().then((value) async {
      bible = await widget.bibleService.loadAsset();
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        booksWidget = buildBibleView(context, bible);
      });
    });
    super.initState();
  }

  Widget buildBibleView(BuildContext context, Bible? bible) {
    List<BIBLEBOOK> books = [];

    if (bible == null) return Container();

    for (BIBLEBOOK book in bible.xMLBIBLE!.bIBLEBOOK) {
      books.add(book);
    }

    return Scaffold(
      body: BooksScreen(settingColor, fontSize, books),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_circle_left),
          backgroundColor: Color(settingColor),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widgetName),
        backgroundColor: Color(settingColor),
      ),
      drawer: const MenuDrawer(),
      body: buildBibleView(context, bible),
    );
  }
}
