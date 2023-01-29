// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_info_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleInfoVersion _$BibleInfoVersionFromJson(Map<String, dynamic> json) =>
    BibleInfoVersion(
      json['name'] as String,
      json['abbr'] as String,
      json['language'] as String,
    );

Map<String, dynamic> _$BibleInfoVersionToJson(BibleInfoVersion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'abbr': instance.abbr,
      'language': instance.language,
    };
