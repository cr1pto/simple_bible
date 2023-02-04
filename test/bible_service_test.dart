import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_info_book.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'test_helpers.dart';

Future main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  GetIt di = await TestHelpers().createContainer();

  group('when BibleService gets current chapter', () {
    test('then gets next chapter successfully', () async {
      BibleService bibleService = getIt();
      BibleInfo bibleInfo = await bibleService.loadInfo();
      Bible bible = await bibleService.loadKJV();
      BibleInfoBook bibleInfoBook = bibleInfo.books[0];
      List<BibleChapter> chapters = bibleService.getChapters(bible, bibleInfoBook);
      BibleChapter currentChapter = chapters[1];

      expect(currentChapter.chapterNumber == 2, true);

      BibleChapter nextChapter = bibleService.getNextChapterFromCurrentChapter(bible, bibleInfo, currentChapter);
      expect(nextChapter.chapterNumber == 3, true);
    });

    test('then gets previous chapter successfully', () async {
      BibleService bibleService = getIt();
      BibleInfo bibleInfo = await bibleService.loadInfo();
      Bible bible = await bibleService.loadKJV();
      BibleInfoBook bibleInfoBook = bibleInfo.books[0];
      List<BibleChapter> chapters = bibleService.getChapters(bible, bibleInfoBook);
      BibleChapter currentChapter = chapters[1];

      expect(currentChapter.chapterNumber == 2, true);

      BibleChapter nextChapter = bibleService.getPreviousChapterFromCurrentChapter(bible, bibleInfo, currentChapter);
      expect(nextChapter.chapterNumber == 1, true);
    });

    test('then gets last chapter from previous book successfully', () async {
      BibleService bibleService = getIt();
      BibleInfo bibleInfo = await bibleService.loadInfo();
      Bible bible = await bibleService.loadKJV();
      BibleInfoBook firstJohnInfo = bibleService.getBookInfoByName(bibleInfo, "1 John");
      BibleInfoBook secondJohnInfo = bibleService.getBookInfoByName(bibleInfo, "2 John");
      List<BibleChapter> chaptersFirstJohn = bibleService.getChapters(bible, firstJohnInfo);
      List<BibleChapter> chaptersSecondJohn = bibleService.getChapters(bible, secondJohnInfo);
      BibleChapter currentChapter =  chaptersSecondJohn.first;
      BibleChapter previousChapter = chaptersFirstJohn.last;

      currentChapter = bibleService.getPreviousChapterFromCurrentChapter(bible, bibleInfo, currentChapter);

      expect(previousChapter.chapterNumber == currentChapter.chapterNumber, true);
    });

    test('then gets first chapter from next book successfully', () async {
      BibleService bibleService = getIt();
      BibleInfo bibleInfo = await bibleService.loadInfo();
      Bible bible = await bibleService.loadKJV();
      BibleInfoBook firstJohnInfo = bibleService.getBookInfoByName(bibleInfo, "1 John");
      BibleInfoBook secondJohnInfo = bibleService.getBookInfoByName(bibleInfo, "2 John");
      List<BibleChapter> chaptersFirstJohn = bibleService.getChapters(bible, firstJohnInfo);
      List<BibleChapter> chaptersSecondJohn = bibleService.getChapters(bible, secondJohnInfo);
      BibleChapter currentChapter = chaptersSecondJohn.first;
      BibleChapter previousChapter = chaptersFirstJohn.last;

      currentChapter = bibleService.getPreviousChapterFromCurrentChapter(bible, bibleInfo, currentChapter);

      expect(previousChapter.chapterNumber == currentChapter.chapterNumber, true);
    });
  });
}
