// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleAppState _$BibleAppStateFromJson(Map<String, dynamic> json) =>
    BibleAppState(
      settingsState:
          SettingsState.fromJson(json['settingsState'] as Map<String, dynamic>),
      bibleState:
          BibleState.fromJson(json['bibleState'] as Map<String, dynamic>),
      chapterState:
          ChapterState.fromJson(json['chapterState'] as Map<String, dynamic>),
      searchState:
          SearchState.fromJson(json['searchState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BibleAppStateToJson(BibleAppState instance) =>
    <String, dynamic>{
      'settingsState': instance.settingsState,
      'bibleState': instance.bibleState,
      'chapterState': instance.chapterState,
      'searchState': instance.searchState,
    };

ChapterState _$ChapterStateFromJson(Map<String, dynamic> json) => ChapterState(
      bookInfo:
          BibleInfoBook.fromJson(json['bookInfo'] as Map<String, dynamic>),
      chapter: BibleChapter.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChapterStateToJson(ChapterState instance) =>
    <String, dynamic>{
      'bookInfo': instance.bookInfo,
      'chapter': instance.chapter,
    };
