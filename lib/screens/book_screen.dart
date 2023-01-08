// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_book.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/chapters_screen.dart';

@Injectable()
class BookScreen extends StatelessWidget {
  final String bookName;
  final BibleBook book;
  final Bible bible;
  final BibleInfo bibleInfo;

  const BookScreen({super.key, required this.bookName, required this.book, required this.bible, required this.bibleInfo});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: bookName,
      floatingBack: true,
      floatingBackHero: "book-back",
      child: ChaptersScreen(bookName: bookName, chapters: book.chapters, bible: bible, bibleInfo: bibleInfo),
    );
  }
}
