import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bible_info_version.g.dart';

@JsonSerializable()
class BibleInfoVersion extends Equatable {
  final String name;
  final String abbr;
  final String language;

  const BibleInfoVersion(
      this.name,
      this.abbr,
      this.language,
      );

  BibleInfoVersion.fromMap(dynamic json)
      : name = json["name"],
        abbr = json["abbr"],
        language = json["language"];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abbr': abbr,
      'language': language,
    };
  }

  @override
  List<Object?> get props => [name, abbr, language];

  factory BibleInfoVersion.fromJson(Map<String, dynamic> json) => _$BibleInfoVersionFromJson(json);

  Map<String, dynamic> toJson() => _$BibleInfoVersionToJson(this);
}