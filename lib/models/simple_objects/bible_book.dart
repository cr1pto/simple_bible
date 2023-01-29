import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';

part 'bible_book.g.dart';

@JsonSerializable()
class BibleBook extends Equatable {
  int bookNumber;
  List<BibleChapter> chapters = <BibleChapter>[];

  BibleBook(
      this.bookNumber,
      this.chapters,
      );

  Map<String, dynamic> toMap() {
    return {
      'bookNumber': bookNumber,
      'chapters': chapters.map((v) => v.toMap()),
    };
  }

  @override
  List<Object?> get props => [bookNumber, chapters];

  factory BibleBook.fromJson(Map<String, dynamic> json) => _$BibleBookFromJson(json);

  Map<String, dynamic> toJson() => _$BibleBookToJson(this);
}