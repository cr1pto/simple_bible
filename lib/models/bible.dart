import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/bible_book.dart';
import 'package:simple_bible/models/bible_chapter.dart';
import 'package:simple_bible/models/bible_verse.dart';
import 'package:simple_bible/services/log.service.dart';

part 'bible.g.dart';

@Injectable()
@JsonSerializable()
class Bible extends Equatable {
  String version;
  List<BibleBook> books = <BibleBook>[];
  final LogService logService = getIt();

  Bible(this.version, this.books);

  Bible.fromMap(this.version, List<dynamic> jsonList) {
    try{
      for (final i in jsonList) {
        int bookNo, chapterNo, verseNo;
        BibleBook book;
        BibleChapter chapter;

        bookNo = int.parse((i['n'] as String).substring(0, 2));
        chapterNo = int.parse((i['n'] as String).substring(2, 5));
        verseNo = int.parse((i['n'] as String).substring(5, 8));

        if (books.where((b) => b.bookNumber == bookNo).isEmpty) {
          books.add(BibleBook(bookNo, const <BibleChapter>[]));
        }
        book = books.firstWhere((b) => b.bookNumber == bookNo);

        if (book.chapters.where((c) => c.chapterNumber == chapterNo).isEmpty) {
          book.chapters.add(BibleChapter(chapterNo, const <BibleVerse>[]));
        }
        chapter = book.chapters.firstWhere((b) => b.chapterNumber == chapterNo);
        chapter.verses.add(BibleVerse(verseNo, i['t'], chapterNo, bookNo));
      }
    }
    catch(exception) {
      logService.error("Failed to setup Bible", exception);
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'books': books.map((b) => b.toMap()),
    };
  }

  @override
  List<Object?> get props => [version, books];

  factory Bible.fromJson(Map<String, dynamic> json) => _$BibleFromJson(json);

  Map<String, dynamic> toJson() => _$BibleToJson(this);
}
