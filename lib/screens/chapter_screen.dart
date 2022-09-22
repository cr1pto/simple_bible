import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/verses_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class ChapterScreen extends StatefulWidget {
  final CHAPTER chapter;
  final String bookName;
  const ChapterScreen(this.bookName, this.chapter, {Key? key})
      : super(key: key);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late Widget versesWidget;
  @override
  void initState() {
    setState(() {
      versesWidget = VersesScreen(
          '${widget.bookName} - ${widget.chapter.sCnumber}',
          widget.chapter.vERS);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      body: versesWidget,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_circle_left),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
