// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/shared/menu_bar.dart';

import 'chapters_screen.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.bookName, required this.book});

  final String bookName;
  final BibleBook book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookName),
        // backgroundColor: Color(settingColor),
      ),
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_circle_left),
      ),
      body: ChaptersScreen(bookName: bookName, chapters: book.chapters),
    );
  }
}
