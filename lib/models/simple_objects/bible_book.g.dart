// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleBook _$BibleBookFromJson(Map<String, dynamic> json) => BibleBook(
      json['bookNumber'] as int,
      (json['chapters'] as List<dynamic>)
          .map((e) => BibleChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibleBookToJson(BibleBook instance) => <String, dynamic>{
      'bookNumber': instance.bookNumber,
      'chapters': instance.chapters,
    };
