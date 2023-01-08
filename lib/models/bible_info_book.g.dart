// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_info_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleInfoBook _$BibleInfoBookFromJson(Map<String, dynamic> json) =>
    BibleInfoBook(
      json['bookNumber'] as int,
      json['name'] as String,
      json['abbr'] as String,
      json['chapterCount'] as int,
      json['testament'] as String,
    );

Map<String, dynamic> _$BibleInfoBookToJson(BibleInfoBook instance) =>
    <String, dynamic>{
      'bookNumber': instance.bookNumber,
      'name': instance.name,
      'abbr': instance.abbr,
      'chapterCount': instance.chapterCount,
      'testament': instance.testament,
    };
