import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

part 'bible_app_state.g.dart';

//the state itself that we want to define in the store
// @immutable
@JsonSerializable()
class BibleAppState{
  SettingsState settingsState = SettingsState.initialState();
  BibleState bibleState = BibleState.initialState();
  ChapterState chapterState = ChapterState.intialState();

  BibleAppState();
  BibleAppState.bibleState({required this.bibleState});
  // BibleAppState.settingsState({required this.settingsState});

  static initialState() {
    return BibleAppState();
  }

  void updateSettings(SettingsState state) {
    settingsState = state;
  }

  void updateBibleState(BibleState state) {
    bibleState = state;
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