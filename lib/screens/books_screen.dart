// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/book_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class BooksScreen extends StatelessWidget {
  final String widgetName = 'Books';
  final List<BibleInfoBook> books;
  final Bible bible;

  const BooksScreen({super.key, required this.books, required this.bible});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_circle_left),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(books[i].name.toString()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BookScreen(
                  bookName: books[i].name,
                  book: bible.books.firstWhere((b) => b.index == i),
                ),
              ));
            },
          );
        },
      ),
    );
  }
}
