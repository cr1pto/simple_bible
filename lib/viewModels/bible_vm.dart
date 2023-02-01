import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';

part 'bible_vm.g.dart';

@JsonSerializable()
class BibleVm {
  BibleInfo bibleInfo = BibleInfo.empty();
  Bible bible = Bible.empty();

  BibleVm({required this.bibleInfo, required this.bible});
  BibleVm.initial();

  factory BibleVm.fromJson(Map<String, dynamic> json) => _$BibleVmFromJson(json);
  Map<String, dynamic> toJson() => _$BibleVmToJson(this);
}