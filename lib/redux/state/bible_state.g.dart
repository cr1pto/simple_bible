// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleState _$BibleStateFromJson(Map<String, dynamic> json) => BibleState(
      bibleVm: BibleVm.fromJson(json['bibleVm'] as Map<String, dynamic>),
      bibleInfoBook:
          BibleInfoBook.fromJson(json['bibleInfoBook'] as Map<String, dynamic>),
      book: BibleBook.fromJson(json['book'] as Map<String, dynamic>),
      chapter: BibleChapter.fromJson(json['chapter'] as Map<String, dynamic>),
      verses: (json['verses'] as List<dynamic>)
          .map((e) => BibleVerse.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => BibleChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentChapter:
          BibleChapter.fromJson(json['currentChapter'] as Map<String, dynamic>),
      previousChapter: BibleChapter.fromJson(
          json['previousChapter'] as Map<String, dynamic>),
      nextChapter:
          BibleChapter.fromJson(json['nextChapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BibleStateToJson(BibleState instance) =>
    <String, dynamic>{
      'bibleVm': instance.bibleVm,
      'bibleInfoBook': instance.bibleInfoBook,
      'book': instance.book,
      'verses': instance.verses,
      'chapters': instance.chapters,
      'chapter': instance.chapter,
      'currentChapter': instance.currentChapter,
      'previousChapter': instance.previousChapter,
      'nextChapter': instance.nextChapter,
    };
