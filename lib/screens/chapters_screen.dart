// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/chapter_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class ChaptersScreen extends StatefulWidget {
  final List<CHAPTER> chapters;
  final String bookName;
  const ChaptersScreen(this.bookName, this.chapters, {Key? key})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChaptersScreenState createState() => _ChaptersScreenState(bookName);
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  late Widget chaptersWidget;
  final String bookName;
  _ChaptersScreenState(this.bookName);
  @override
  void initState() {
    setState(() {
      List<Widget> allChapters = [];

      for (CHAPTER chapter in widget.chapters) {
        allChapters.add(ListTile(
            title: Text(chapter.sCnumber ?? ''),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ChapterScreen(widget.bookName, chapter)));
            }));
      }

      chaptersWidget = Scaffold(
        body: ListView(children: allChapters),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            heroTag: bookName,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_circle_left)),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: chaptersWidget,
    );
  }
}
