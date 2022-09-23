// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/services/bible.service.dart';

import '../models/bible.dart';

class BookSearchScreen extends StatefulWidget {
  final List<BIBLEBOOK> books;
  final int settingColor;
  final double fontSize;
  final BibleService bibleService = BibleService();
  BookSearchScreen(this.settingColor, this.fontSize, this.books, {Key? key})
      : super(key: key);

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  static List<String> availableBooks = [];
  Widget bookWidget = const ListTile();
  BIBLEBOOK? selectedBook;
  final TextEditingController txtSearch = TextEditingController();

  Widget getBook() => bookWidget;

  @override
  Widget build(BuildContext context) {
    availableBooks = widget.books.map((book) => book.sBname ?? '').toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search the Bible for...'),
          // backgroundColor: Color(settingColor),
        ),
        body: ListView(
          children: [
            TextField(
                controller: txtSearch,
                decoration: InputDecoration(
                    hintText: 'Search the Bible...',
                    prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            bookWidget = widget.bibleService
                                .getBookScreenByName(
                                    selectedBook?.sBname ?? '', widget.books);
                          });
                        },
                        icon: const Icon(Icons.book_online)))),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return availableBooks.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String book) {
                setState(() {
                  // selectedBook = widget.bibleService.getBookByName(book, widget.books);
                  bookWidget = widget.bibleService
                      .getBookScreenByName(book, widget.books);
                });
              },
            ),
            getBook()
          ],
        ));
  }
}
