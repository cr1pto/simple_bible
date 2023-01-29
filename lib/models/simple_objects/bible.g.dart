// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bible _$BibleFromJson(Map<String, dynamic> json) => Bible(
      json['version'] as String,
      (json['books'] as List<dynamic>)
          .map((e) => BibleBook.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibleToJson(Bible instance) => <String, dynamic>{
      'version': instance.version,
      'books': instance.books,
    };
