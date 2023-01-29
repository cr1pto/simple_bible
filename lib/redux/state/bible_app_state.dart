import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

part 'bible_app_state.g.dart';

//the state itself that we want to define in the store
@immutable
@JsonSerializable()
class BibleAppState{
  // final BibleBook book;
  // final BibleChapter chapter;
  // final List<BibleVerse> verses;
  final SettingsState settingsState = SettingsState.initialState();
  final BibleState bibleState = BibleState.initialState();
  final ChapterState chapterState = ChapterState.intialState();

  BibleAppState();

  static initialState() {
    return BibleAppState();
  }

  factory BibleAppState.fromJson(Map<String, dynamic> json) => _$BibleAppStateFromJson(json);
  Map<String, dynamic> toJson() => _$BibleAppStateToJson(this);

}

class ChapterState {
  final BibleInfoBook bookInfo = BibleInfoBook(0, "", "", 0, "");
  final BibleChapter chapter = BibleChapter(0, List.empty());

  static ChapterState intialState() {
    return ChapterState();
  }
}