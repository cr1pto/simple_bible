// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleChapter _$BibleChapterFromJson(Map<String, dynamic> json) => BibleChapter(
      json['chapterNumber'] as int,
      (json['verses'] as List<dynamic>)
          .map((e) => BibleVerse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibleChapterToJson(BibleChapter instance) =>
    <String, dynamic>{
      'chapterNumber': instance.chapterNumber,
      'verses': instance.verses,
    };
