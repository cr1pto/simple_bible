import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bible_verse.g.dart';

@JsonSerializable()
class BibleVerse extends Equatable {
  int? id;
  int verseNumber = 0;
  String text = "";
  int chapterNumber = 0;
  int bookNumber = 0;

  BibleVerse(
      this.verseNumber,
      this.text,
      this.chapterNumber,
      this.bookNumber
      );
  BibleVerse.initial();

  Map<String, dynamic> toMap() => _$BibleVerseToJson(this);

  BibleVerse.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    verseNumber = map['verseNumber'];
    text = map['text'];
    chapterNumber = map['chapterNumber'];
    bookNumber = map['bookNumber'];
  }

  @override
  List<Object?> get props => [id, verseNumber, text, chapterNumber, bookNumber];

  factory BibleVerse.fromJson(Map<String, dynamic> json) => _$BibleVerseFromJson(json);

  Map<String, dynamic> toJson() => _$BibleVerseToJson(this);
}
