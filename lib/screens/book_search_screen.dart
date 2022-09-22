import 'package:flutter/material.dart';

import '../models/bible.dart';

class BookSearchScreen extends StatefulWidget {
  final List<BIBLEBOOK> books;
  final int settingColor;
  final double fontSize;
  const BookSearchScreen(this.settingColor, this.fontSize, this.books, {Key? key}) : super(key: key);

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  static List<String> availableBooks = [];
  @override
  Widget build(BuildContext context) {
    availableBooks =  widget.books.map((book) => book.sBname ?? '').toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search the Bible for...'),
        // backgroundColor: Color(settingColor),
      ),
      body: Row(
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return availableBooks.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              debugPrint('You just selected $selection');
            },
          ),

        ],
      )
      );
  }
}
