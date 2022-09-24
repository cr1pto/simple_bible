import 'package:simple_bible/models/bible.dart';

class BibleSerializationException implements Exception {
  Bible? bible;
  BIBLEBOOK? bibleBook;
  CHAPTER? chapter;
  VERS? verse;
  String cause = "Serialization failed.";
  BibleSerializationException(this.bible, this.bibleBook, this.chapter, this.verse);
}