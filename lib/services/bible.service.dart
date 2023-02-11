import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/services/log.service.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

@Injectable()
class BibleService {
  final LogService logService = LogService();
  String infoAsset = 'assets/bibles/info.json';
  String kjvAsset = 'assets/bibles/basic/kjv.json';

  BibleService();

  Future<BibleVm> loadBible() async {
    try {
      final info = await loadInfo();
      final bible = await loadKJV();
      return BibleVm(bibleInfo: info, bible: bible);
      // emit(BibleLoaded(info: info, bible: bible));
    } catch (e) {
      logService.fatal("Error loading bible:", e, Error().stackTrace);
      const String message = "Failed to load bible";
      // emit(const BibleLoadFailed(message: message));
      rethrow;
    }
  }

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

  BibleChapter getLastChapterFromPreviousBook(Bible bible, BibleInfo bibleInfo, BibleInfoBook bookInfo, int chapterNumberIndex) {
    int bookIndex = -1;
    BibleChapter previousChapter;

    if(bookInfo.bookNumber < 0) bookIndex = 0;

    //get the current book
    bookIndex = bookInfo.bookNumber - 1;

    if(chapterNumberIndex <= 0 && bookIndex <= 0) return bible.books[0].chapters[0];

    //decrement the book number
    bookIndex--;

    //is this Genesis?
    if(bookIndex < 0) bookIndex = 0;

    //get the previous book
    BibleBook previousBook = bible.books[bookIndex];
    // BibleInfoBook previousBookInfo = bibleInfo.books[bookIndex];

    previousChapter = previousBook.chapters.last;

    bookInfo = bibleInfo.books[bookIndex];

    return previousChapter;
  }

  BibleChapter getFirstChapterFromNextBook(Bible bible, BibleInfo bibleInfo, BibleInfoBook bookInfo, int chapterNumberIndex) {
    int bookIndex = -1;
    BibleChapter nextChapter;

    if(bookInfo.bookNumber < 0) bookIndex = 0;

    //get the current book
    bookIndex = bookInfo.bookNumber - 1;

    if(chapterNumberIndex >= 21 && bookIndex >= 65) return bible.books[21].chapters[65];

    //increment the book number
    bookIndex++;

    //is this Revelation?
    if(bookIndex >= 65) bookIndex = 65;

    //get the previous book
    BibleBook nextBook = bible.books[bookIndex];

    nextChapter = nextBook.chapters.first;
    bookInfo = bibleInfo.books[bookIndex];

    return nextChapter;
  }

  BibleChapter getNextChapter(Bible bible, BibleInfo bibleInfo, BibleInfoBook bookInfo, int chapterNumberIndex) {
    int bookIndex = -1;
    int nextChapterIndex = -1;
    BibleChapter nextChapter;

    if(bookInfo.bookNumber < 0) bookIndex = 0;

    //get the current book
    bookIndex = bookInfo.bookNumber - 1;

    //is this Revelation?
    if(bookIndex >= 66) bookIndex = 65;
    //is this the last chapter?
    // if(bookIndex == bookInfo.bookNumber - 1 && bible.books.last.chapters.last.chapterNumber >= chapterNumberIndex + 1) nextChapterIndex = bible.books.last.chapters.last.chapterNumber - 1;

    BibleBook book = bible.books[bookIndex];

    nextChapterIndex = chapterNumberIndex + 1;

    nextChapter = book.chapters[nextChapterIndex];

    return nextChapter;
  }

  BibleChapter getPreviousChapter(Bible bible, BibleInfo bibleInfo, BibleInfoBook bookInfo, int chapterNumberIndex) {
    int bookIndex = -1;
    int prevChapterIndex = -1;
    BibleChapter prevChapter;

    if(bookInfo.bookNumber < 0) bookIndex = 0;

    //get the current book
    bookIndex = bookInfo.bookNumber - 1;
    //increment the book number

    //is this Genesis?
    if(bookIndex < 0) bookIndex = 0;

    BibleBook book = bible.books[bookIndex];

    prevChapterIndex = chapterNumberIndex - 1;
    prevChapter = book.chapters[prevChapterIndex];

    return prevChapter;
  }


  BibleChapter getChapterFromVerse(Bible bible, BibleInfo bibleInfo, BibleVerse verse) {
    BibleInfoBook bibleInfoBook = bibleInfo.books[verse.bookNumber - 1];
    return bible.books[bibleInfoBook.bookNumber - 1].chapters[verse.chapterNumber - 1];
  }

  BibleChapter getPreviousChapterFromCurrentChapter(Bible bible, BibleInfo bibleInfo, BibleChapter currentChapter){
    BibleInfoBook bibleInfoBook = bibleInfo.books[currentChapter.verses[0].bookNumber - 1];
    BibleChapter previousChapter;
    if(isFirstChapter(currentChapter)) {
      previousChapter = getLastChapterFromPreviousBook(bible, bibleInfo, bibleInfoBook, currentChapter.chapterNumber - 1);
    }
    else{
      //TODO: error scenario - just return the current chapter
      previousChapter = getPreviousChapter(bible, bibleInfo, bibleInfoBook, currentChapter.chapterNumber - 1);
    }

    return previousChapter;
  }

  bool isLastChapter(BibleChapter chapter, BibleInfoBook bibleInfoBook) => chapter.chapterNumber == bibleInfoBook.chapterCount;

  bool isFirstChapter(BibleChapter chapter) => chapter.chapterNumber == 1;

  BibleInfoBook getBookInfoByName(BibleInfo bibleInfo, String bookName) => bibleInfo.books.firstWhere((element) => element.name == bookName);

  BibleBook getBookByName(Bible bible, BibleInfo bibleInfo, String bookName) {
    var bookInfo = bibleInfo.books.firstWhere((element) => element.name == bookName);
    return bible.books.firstWhere((element) => element.bookNumber == bookInfo.bookNumber);
  }

  BibleChapter getNextChapterFromCurrentChapter(Bible bible, BibleInfo bibleInfo, BibleChapter currentChapter){
    BibleInfoBook bibleInfoBook = bibleInfo.books[currentChapter.verses[0].bookNumber - 1];
    BibleChapter nextChapter;

    if(isLastChapter(currentChapter, bibleInfoBook)) {
      nextChapter = getFirstChapterFromNextBook(bible, bibleInfo, bibleInfoBook, currentChapter.chapterNumber - 1);
    }
    else{
      nextChapter = getNextChapter(bible, bibleInfo, bibleInfoBook, currentChapter.chapterNumber - 1);
    }

    return nextChapter;
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

  List<BibleVerse> getVerseFromSearchCriteria(Bible bible, BibleInfo bibleInfo, String searchText) {
    List<BibleVerse> verses = <BibleVerse>[];

    if(searchText == "") return verses;

    //move all verses to sqlite db store for long-term retention
    for(var i = 0; i < bible.books.length; i++) {
      for(var j = 0; j < bible.books[i].chapters.length; j++) {
        verses.addAll(bible.books[i].chapters[j].verses.where((element) => element.text.toUpperCase().contains(searchText.toUpperCase())));
      }
    }

    return verses;
  }

  String getBookNameByBookNumber(BibleInfo bibleInfo, int bookNumber) {
    return bibleInfo.books.firstWhere((element) => element.bookNumber == bookNumber, orElse: BibleInfoBook.initial).name;
  }
}
