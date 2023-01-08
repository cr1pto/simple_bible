// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/book_screen.dart';

class BooksScreen extends StatelessWidget {
  final String widgetName = 'Books';
  final Bible bible;
  final BibleInfo bibleInfo;

  const BooksScreen({super.key, required this.bibleInfo, required this.bible});

  openSelectedBook(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BookScreen(
        bookName: bibleInfo.books.firstWhere((b) => b.bookNumber == index).name,
        book: bible.books.firstWhere((b) => b.bookNumber == index),
        bible: bible,
        bibleInfo: bibleInfo
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ListView.builder(
        itemCount: bibleInfo.books.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text(bibleInfo.books[i].name.toString(),
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0,
                  )),
              onTap: () => {
                openSelectedBook(context, i + 1),
              },
            ),
          );
        },
      ),
    );
  }
}
