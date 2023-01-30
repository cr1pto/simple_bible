import 'package:flutter/material.dart';
import 'package:simple_bible/components/verse.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

// @immutable
class BibleState {
  static BibleState initialState() {
    return BibleState();
  }

  BibleVm? bibleVm;
  final BibleInfoBook bibleInfoBook = BibleInfoBook(0, "", "", 0, "");
  final BibleBook book = BibleBook(0, List.empty());
  final BibleChapter chapters = BibleChapter(0, List.empty());
  final List<Verse> verses = List.empty();

  BibleState();
  BibleState.bible(this.bibleVm);
}