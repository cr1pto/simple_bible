import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/redux/state/search_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

part 'bible_app_state.g.dart';

//the state itself that we want to define in the store
@immutable
@JsonSerializable()
class BibleAppState{
  SettingsState settingsState = SettingsState.initial();
  BibleState bibleState = BibleState.initial();
  ChapterState chapterState = ChapterState.initial();
  SearchState searchState = SearchState.initial();

  BibleAppState({required this.settingsState, required this.bibleState, required this.chapterState, required this.searchState});
  BibleAppState.initial();
  BibleAppState.bibleState({required this.bibleState});

  factory BibleAppState.fromJson(Map<String, dynamic> json) => _$BibleAppStateFromJson(json);
  Map<String, dynamic> toJson() => _$BibleAppStateToJson(this);
}

@immutable
@JsonSerializable()
class ChapterState {
  BibleInfoBook bookInfo = BibleInfoBook.initial();
  BibleChapter chapter = BibleChapter.initial();
  bool hasJumpedToVerse = false;

  ChapterState({required this.bookInfo, required this.chapter, required this.hasJumpedToVerse});
  ChapterState.initial();

  factory ChapterState.fromJson(Map<String, dynamic> json) => _$ChapterStateFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterStateToJson(this);
}