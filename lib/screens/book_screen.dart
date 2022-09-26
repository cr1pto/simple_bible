// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';

import '../layouts/main_layout.dart';
import 'chapters_screen.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.bookName, required this.book});

  final String bookName;
  final BibleBook book;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: bookName,
      floatingBack: true,
      floatingBackHero: "book-back",
      child: ChaptersScreen(bookName: bookName, chapters: book.chapters),
    );
  }
}
