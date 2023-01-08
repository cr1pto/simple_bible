import 'package:flutter_test/flutter_test.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  LogService logService = LogService();
  BibleService bibleService = BibleService(logService);

  group('Verse', () {
    test('loads bible info successfully', () async {
      BibleInfo info = await bibleService.loadInfo();
      expect(info != null, true);
      expect(info.versions.isNotEmpty, true);
      expect(info.books.isNotEmpty, true);
      expect(info.books[0].bookNumber == 1, true);
    });
    test('loads simple kjv successfully', () async {
      Bible bible = await bibleService.loadKJV();
      expect(bible != null, true);
      expect(bible.version == "kjv", true);
      expect(bible.books.isNotEmpty, true);
      expect(bible.books[0].bookNumber == 1, true);
      expect(bible.books[0].chapters.isNotEmpty, true);
      expect(bible.books[0].chapters[0].chapterNumber == 1, true);
      expect(bible.books[0].chapters[0].verses.isNotEmpty, true);
      expect(bible.books[0].chapters[0].verses[0].verseNumber == 1, true);
    });
  });
}
