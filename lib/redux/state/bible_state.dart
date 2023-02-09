import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_book.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

part 'bible_state.g.dart';

@immutable
@JsonSerializable()
class BibleState {
  BibleVm bibleVm = BibleVm.initial();
  BibleInfoBook bibleInfoBook = BibleInfoBook.initial();
  BibleBook book = BibleBook.initial();
  List<BibleVerse> verses = <BibleVerse>[];
  List<BibleChapter> chapters = <BibleChapter>[];
  BibleChapter chapter = BibleChapter.initial();
  BibleChapter currentChapter = BibleChapter.initial();
  BibleChapter previousChapter = BibleChapter.initial();
  BibleChapter nextChapter = BibleChapter.initial();
  BibleVerse currentVerse = BibleVerse.initial();

  BibleState({required this.bibleVm, required this.bibleInfoBook, required this.book, required this.chapter, required this.verses, required this.chapters, required this.currentChapter, required this.previousChapter, required this.nextChapter, required this.currentVerse});
  BibleState.initial();
  BibleState.bible({required this.bibleVm});

  factory BibleState.fromJson(Map<String, dynamic> json) => _$BibleStateFromJson(json);
  Map<String, dynamic> toJson() => _$BibleStateToJson(this);
}