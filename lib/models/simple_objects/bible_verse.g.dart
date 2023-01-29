// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleVerse _$BibleVerseFromJson(Map<String, dynamic> json) => BibleVerse(
      json['verseNumber'] as int,
      json['text'] as String,
      json['chapterNumber'] as int,
      json['bookNumber'] as int,
    )..id = json['id'] as int?;

Map<String, dynamic> _$BibleVerseToJson(BibleVerse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'verseNumber': instance.verseNumber,
      'text': instance.text,
      'chapterNumber': instance.chapterNumber,
      'bookNumber': instance.bookNumber,
    };
