import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/book_screen.dart';

class BibleService {
  String kjvBibleAsset = 'assets/bibles/kjv.json';

  Future<Bible?> loadAsset() async {
    String jsonText = await rootBundle.loadString(kjvBibleAsset);
    Map<String, Object?> bibleMap = json.decode(jsonText);
    Bible bible = Bible.fromMap(bibleMap);
    return bible;
  }

  Future<List<BIBLEBOOK>> getBooks() async {
    Bible? bible = await loadAsset();
    List<BIBLEBOOK> books = [];

    if(bible == null) return <BIBLEBOOK>[];

    for (BIBLEBOOK book in bible.xMLBIBLE!.bIBLEBOOK) {
      books.add(book);
    }
    return books;
  }

  List<BIBLEBOOK> getBooksFromBible(Bible? bible)  {
    List<BIBLEBOOK> books = [];

    if(bible == null) return <BIBLEBOOK>[];

    for (BIBLEBOOK book in bible.xMLBIBLE!.bIBLEBOOK) {
      books.add(book);
    }

    return books;
  }

  List<Widget> buildBooksWidget(List<BIBLEBOOK> books, BuildContext context) {
    List<Widget> allBookWidgets = [];
    for (BIBLEBOOK book in books) {
      allBookWidgets.add(ListTile(
          title: Text(book.sBname ?? ''),
          onTap: () {
            // pop the stack so that the drawer doesn't open up again since it gets pushed onto the navigation route stack
            // Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BookScreen(book)));
          }));
    }

    return allBookWidgets;
  }
}
