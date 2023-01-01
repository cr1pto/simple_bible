import 'dart:convert';
import 'dart:math';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/services.dart';
import 'package:simple_bible/models/bible.dart';

class BibleService {
  String infoAsset = 'assets/bibles/info.json';
  String kjvAsset = 'assets/bibles/basic/kjv.json';

  Future<BibleInfo> loadInfo() async {
    String jsonText = await rootBundle.loadString(infoAsset);
    Map<String, dynamic> bibleInfoMap = json.decode(jsonText);
    return BibleInfo.fromMap(bibleInfoMap);
  }

  Future<Bible> loadKJV() async {
    String jsonText = await rootBundle.loadString(kjvAsset);
    List<dynamic> bibleMap = json.decode(jsonText);
    return Bible.fromMap("kjv", bibleMap);
  }

  BibleInfoBook getBookInfoFromBookNumberIndex(Bible bible, BibleInfo bibleInfo, int bookNumberIndex) {
    if(bookNumberIndex <= 0) bookNumberIndex = 0;
    return bibleInfo.books[bookNumberIndex];
  }

  BibleChapter getChapterInfoFromNumberIndex(Bible bible, BibleInfoBook bookInfo, int chapterNumberIndex) {
    if(chapterNumberIndex <= 0) chapterNumberIndex = 0;
    return bible.books[bookInfo.index].chapters[chapterNumberIndex];
  }

  List<BibleChapter> getChapters(Bible bible, BibleInfoBook bookInfo) {
    return bible.books[bookInfo.index].chapters;
  }

  List<BibleVerse> getVerses(Bible bible, BibleInfoBook book, int chapterNumberIndex) {
    if(chapterNumberIndex <= 0) chapterNumberIndex = 0;
    return bible.books[book.index].chapters[chapterNumberIndex].verses;
  }

  BibleVerse getVerse(Bible bible, BibleInfoBook book, int chapterNumberIndex, int verseNumberIndex) {
    if(chapterNumberIndex <= 0) chapterNumberIndex = 0;
    if(verseNumberIndex <= 0) verseNumberIndex = 0;
    return bible.books[book.index].chapters[chapterNumberIndex].verses[verseNumberIndex];
  }

  String getVerseInfo(Bible bible, BibleInfoBook book, int chapterNumberIndex, int verseNumberIndex) {
    if(chapterNumberIndex <= 0) chapterNumberIndex = 0;
    if(verseNumberIndex <= 0) verseNumberIndex = 0;
    BibleVerse verse = getVerse(bible, book, chapterNumberIndex, verseNumberIndex);
    return "Book Name: ${book.name}\n${verse.chapterNumber}\n${verse.text}";
  }

  String getRandomVerse(BibleInfo bibleInfo, Bible bible) {
    try{
      Random random = Random(DateTime.now().microsecondsSinceEpoch);
      int bookNumber = random.nextInt(66);
      if(bookNumber <= 0) bookNumber = 1;
      BibleInfoBook book = getBookInfoFromBookNumberIndex(bible, bibleInfo, bookNumber - 1);
      int chapterNumber = random.nextInt(book.chapterCount);
      if(chapterNumber <= 0) chapterNumber = 1;

      int verseCount = getVerses(bible, book, chapterNumber - 1).length;
      int verseNumber = random.nextInt(verseCount);
      BibleVerse verse = getVerse(bible, book, chapterNumber - 1, verseNumber - 1);

      String bookName = getBookInfoFromBookNumberIndex(bible, bibleInfo, verse.bookNumber - 1).name;

      return "$bookName ${verse.chapterNumber}:${verse.index} - ${verse.text}";
    }
    catch(exception) {
      FLog.error(exception: exception, text: "Failed to generate random verse.");
      //fallback to gen. 1:1
      BibleInfoBook book = getBookInfoFromBookNumberIndex(bible, bibleInfo, 0);
      BibleVerse verse = getVerse(bible, book, 0, 0);
      String bookName = getBookInfoFromBookNumberIndex(bible, bibleInfo, 0).name;
      return "$bookName ${verse.chapterNumber}:${verse.index} - ${verse.text}";
    }
  }
}
