import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/shared/menu_bar.dart';

import 'chapters_screen.dart';

class BookScreen extends StatefulWidget {
  final BIBLEBOOK book;
  const BookScreen(this.book, {Key? key}) : super(key: key);

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late Widget chaptersScreen;
  late String bookName;

  @override
  void initState() {
    bookName = widget.book.sBname ?? '';
    setState(() {
      // chaptersScreen = getChapters();
    });
    super.initState();
  }

  Widget getChapters() {
    return ChaptersScreen(bookName, widget.book.cHAPTER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.sBname ?? ''),
        // backgroundColor: Color(settingColor),
      ),
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      body: ChaptersScreen(bookName, widget.book.cHAPTER),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_circle_left),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
