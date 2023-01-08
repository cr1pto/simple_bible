import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bible_info_book.g.dart';

@JsonSerializable()
class BibleInfoBook extends Equatable {
  int bookNumber;
  String name;
  String abbr;
  int chapterCount;
  String testament;

  BibleInfoBook(
      this.bookNumber,
      this.name,
      this.abbr,
      this.chapterCount,
      this.testament,
      );

  // BibleInfoBook.fromMap(dynamic json) => _$BibleInfoBookFromJson(json);

  BibleInfoBook.fromMap(dynamic json)
      : bookNumber = json["bookNumber"],
        name = json["name"],
        abbr = json["abbr"],
        chapterCount = json["chapterCount"],
        testament = json["testament"];

  // Map<String, dynamic> toMap() {
  //   return {
  //     'bookNumber': bookNumber,
  //     'name': name,
  //     'abbr': abbr,
  //     'chapterCount': chapterCount,
  //     'testament': testament,
  //   };
  // }

  Map<String, dynamic> toMap() => _$BibleInfoBookToJson(this);

  @override
  List<Object?> get props => [bookNumber, name, abbr, chapterCount, testament];

  factory BibleInfoBook.fromJson(Map<String, dynamic> json) => _$BibleInfoBookFromJson(json);

  Map<String, dynamic> toJson() => _$BibleInfoBookToJson(this);
}