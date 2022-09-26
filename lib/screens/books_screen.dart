// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/book_screen.dart';

class BooksScreen extends StatelessWidget {
  final String widgetName = 'Books';
  final List<BibleInfoBook> books;
  final Bible bible;

  const BooksScreen({super.key, required this.books, required this.bible});

  openSelectedBook(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BookScreen(
        bookName: books.firstWhere((b) => b.index == index).name,
        book: bible.books.firstWhere((b) => b.index == index),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(books[i].name.toString()),
            onTap: () => {
              openSelectedBook(context, i + 1),
            },
          );
        },
      ),
    );
  }
}
