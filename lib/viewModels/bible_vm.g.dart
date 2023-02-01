// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_vm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleVm _$BibleVmFromJson(Map<String, dynamic> json) => BibleVm(
      bibleInfo: BibleInfo.fromJson(json['bibleInfo'] as Map<String, dynamic>),
      bible: Bible.fromJson(json['bible'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BibleVmToJson(BibleVm instance) => <String, dynamic>{
      'bibleInfo': instance.bibleInfo,
      'bible': instance.bible,
    };
