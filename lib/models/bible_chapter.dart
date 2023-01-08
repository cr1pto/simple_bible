import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/bible_verse.dart';

part 'bible_chapter.g.dart';

@JsonSerializable()
class BibleChapter extends Equatable {
  int chapterNumber;
  List<BibleVerse> verses = <BibleVerse>[];

  BibleChapter(
      this.chapterNumber,
      this.verses,
      );

  Map<String, dynamic> toMap() {
    return {
      'chapterNumber': chapterNumber,
      'verses': verses.map((v) => v.toMap()),
    };
  }

  @override
  List<Object?> get props => [chapterNumber, verses];

  factory BibleChapter.fromJson(Map<String, dynamic> json) => _$BibleChapterFromJson(json);

  Map<String, dynamic> toJson() => _$BibleChapterToJson(this);
}