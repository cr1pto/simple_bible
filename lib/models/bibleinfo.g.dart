// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bibleinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleInfo _$BibleInfoFromJson(Map<String, dynamic> json) => BibleInfo(
      (json['versions'] as List<dynamic>)
          .map((e) => BibleInfoVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['books'] as List<dynamic>)
          .map((e) => BibleInfoBook.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibleInfoToJson(BibleInfo instance) => <String, dynamic>{
      'versions': instance.versions,
      'books': instance.books,
    };
