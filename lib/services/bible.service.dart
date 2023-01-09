import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bible_info_book.dart';
import 'package:simple_bible/models/bible_verse.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/services/log.service.dart';

@Injectable()
class BibleService {
  String infoAsset = 'assets/bibles/info.json';
  String kjvAsset = 'assets/bibles/basic/kjv.json';
  final LogService logService = getIt();

  BibleService();

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
    if(bookNumberIndex < 0) bookNumberIndex = 0;
    return bibleInfo.books[bookNumberIndex];
  }

  BibleChapter getChapterInfoFromNumberIndex(Bible bible, BibleInfoBook bookInfo, int chapterNumberIndex) {
    if(chapterNumberIndex < 0) chapterNumberIndex = 0;
    if(chapterNumberIndex > bible.books[bookInfo.bookNumber - 1].chapters.length - 1) chapterNumberIndex = 0;
    return bible.books[bookInfo.bookNumber - 1].chapters[chapterNumberIndex];
  }

  BibleChapter getChapterFromVerse(Bible bible, BibleInfo bibleInfo, BibleVerse verse) {
    BibleInfoBook bibleInfoBook = bibleInfo.books[verse.bookNumber - 1];
    return bible.books[bibleInfoBook.bookNumber - 1].chapters[verse.chapterNumber - 1];
  }

  BibleChapter getPreviousChapterFromCurrentChapter(Bible bible, BibleInfo bibleInfo, BibleChapter currentChapter){
    BibleInfoBook bibleInfoBook = bibleInfo.books[currentChapter.verses[0].bookNumber - 1];
    BibleChapter previousChapter;
    if(isFirstChapter(currentChapter)) {
      //TODO: is this the first chapter of the entire Bible?
      previousChapter = getChapterInfoFromNumberIndex(bible, bibleInfoBook, currentChapter.chapterNumber - 1);
    }
    else if(isLastChapter(currentChapter, bibleInfoBook)) {
      //TODO: is this the last chapter of the entire Bible?
      previousChapter = getChapterInfoFromNumberIndex(bible, bibleInfoBook, currentChapter.chapterNumber - 2);
    }
    else{
      //TODO: error scenario - just return the current chapter
      previousChapter = getChapterInfoFromNumberIndex(bible, bibleInfoBook, currentChapter.chapterNumber - 2);
    }

    return previousChapter;
  }

  bool isLastChapter(BibleChapter chapter, BibleInfoBook bibleInfoBook) => chapter.chapterNumber == bibleInfoBook.chapterCount;

  bool isFirstChapter(BibleChapter chapter) => chapter.chapterNumber == 1;

  BibleChapter getNextChapterFromCurrentChapter(Bible bible, BibleInfo bibleInfo, BibleChapter currentChapter){
    BibleInfoBook bibleInfoBook = bibleInfo.books[currentChapter.verses[0].bookNumber - 1];
    BibleChapter nextChapter;
    if(isFirstChapter(currentChapter)) {
      //TODO: is this the first chapter of the entire Bible?
      nextChapter = getChapterInfoFromNumberIndex(bible, bibleInfoBook, currentChapter.chapterNumber);
    }
    else if(isLastChapter(currentChapter, bibleInfoBook)) {
      //TODO: is this the last chapter of the entire Bible?
      nextChapter = getChapterInfoFromNumberIndex(bible, bibleInfoBook, currentChapter.chapterNumber - 1);
    }
    else{
      //TODO: error scenario - just return the current chapter
      nextChapter = getChapterInfoFromNumberIndex(bible, bibleInfoBook, currentChapter.chapterNumber);
    }

    return nextChapter;
  }

  BibleChapter getPreviousChapterFromVerse(Bible bible, BibleInfo bibleInfo, BibleVerse verse) {
    int currentChapterIndex = verse.chapterNumber - 1;
    BibleInfoBook currentBookInfo = bibleInfo.books[currentChapterIndex];

    //go to the previous book
    if(currentChapterIndex < 0) {
      BibleInfoBook previousBookInfo = bibleInfo.books[currentChapterIndex - 1];

      return bible.books[previousBookInfo.bookNumber - 1].chapters[verse.chapterNumber - 1];
    }

    return bible.books[currentBookInfo.bookNumber - 1].chapters[verse.chapterNumber - 1];
  }

  BibleChapter getNextChapterFromVerse(Bible bible, BibleInfo bibleInfo, BibleVerse verse) {
    int currentChapterIndex = verse.chapterNumber -1;
    BibleInfoBook bibleInfoBook = bibleInfo.books[verse.chapterNumber -1];
    return bible.books[bibleInfoBook.bookNumber - 1].chapters[verse.chapterNumber - 1];
  }

  List<BibleChapter> getChapters(Bible bible, BibleInfoBook bookInfo) {
    return bible.books[bookInfo.bookNumber - 1].chapters;
  }

  List<BibleVerse> getVerses(Bible bible, BibleInfoBook book, int chapterNumberIndex) {
    if(chapterNumberIndex < 0) chapterNumberIndex = 0;
    return bible.books[book.bookNumber - 1].chapters[chapterNumberIndex].verses;
  }

  BibleVerse getVerse(Bible bible, BibleInfoBook book, int chapterNumberIndex, int verseNumberIndex) {
    if(chapterNumberIndex < 0) chapterNumberIndex = 0;
    if(verseNumberIndex < 0) verseNumberIndex = 0;
    return bible.books[book.bookNumber - 1].chapters[chapterNumberIndex].verses[verseNumberIndex];
  }

  String getVerseInfo(Bible bible, BibleInfoBook book, int chapterNumberIndex, int verseNumberIndex) {
    if(chapterNumberIndex < 0) chapterNumberIndex = 0;
    if(verseNumberIndex < 0) verseNumberIndex = 0;
    BibleVerse verse = getVerse(bible, book, chapterNumberIndex, verseNumberIndex);
    return "Book Name: ${book.name}\n${verse.chapterNumber}\n${verse.text}";
  }

  BibleVerse getRandomVerse(BibleInfo bibleInfo, Bible bible) {
    try{
      Random random = Random(DateTime.now().microsecondsSinceEpoch);
      int bookNumber = random.nextInt(66);
      if(bookNumber < 0) bookNumber = 1;
      BibleInfoBook book = getBookInfoFromBookNumberIndex(bible, bibleInfo, bookNumber - 1);
      int chapterNumber = random.nextInt(book.chapterCount);
      if(chapterNumber < 0) chapterNumber = 1;

      int verseCount = getVerses(bible, book, chapterNumber - 1).length;
      int verseNumber = random.nextInt(verseCount);
      BibleVerse verse = getVerse(bible, book, chapterNumber - 1, verseNumber - 1);

      // getBookInfoFromBookNumberIndex(bible, bibleInfo, verse.bookNumber - 1);
      //"$bookName ${verse.chapterNumber}:${verse.index} - ${verse.text}"
      return verse;
    }
    catch(exception, stacktrace) {
      logService.error("Failed to generate random verse.", exception, stacktrace);
      //fallback to gen. 1:1
      BibleInfoBook book = getBookInfoFromBookNumberIndex(bible, bibleInfo, 0);
      BibleVerse verse = getVerse(bible, book, 0, 0);
      // String bookName = getBookInfoFromBookNumberIndex(bible, bibleInfo, 0).name;
      // return "$bookName ${verse.chapterNumber}:${verse.index} - ${verse.text}";
      return verse;
    }
  }

  static getInstance() {
    return BibleService();
  }
}
