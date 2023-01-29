import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';

class BibleVm {
  final BibleInfoBook bibleInfoBook;
  final BibleBook bible;

  BibleVm(this.bibleInfoBook, this.bible);
}