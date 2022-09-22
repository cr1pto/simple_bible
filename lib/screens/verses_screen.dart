import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/verse_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class VersesScreen extends StatefulWidget {
  final List<VERS> verses;
  final String bookName;
  const VersesScreen(this.bookName, this.verses, {Key? key}) : super(key: key);

  @override
  _VersesScreenState createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late Widget versesWidget;
  @override
  void initState() {
    setState(() {
      List<Widget> allVerses = [];

      for (VERS verse in widget.verses) {
        allVerses.add(VerseScreen(verse));
      }

      versesWidget = ListView(children: allVerses);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
        // backgroundColor: Color(settingColor),
      ),
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      body: versesWidget,
    );
  }
}
