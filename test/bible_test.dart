
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/services/bible.service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  String kjvSingleChapterBibleAsset = 'assets/bibles/test_single_book_bible.json';
  String kjvBibleMultipleChsAsset = 'assets/bibles/test_single_book_multiple_chs.json';
  var bibleService = BibleService();

  group('Verse', () {
    test('serializes kjvSingleChapterBibleAsset successfully', () async {
      Bible? bible = await bibleService.loadAssetByNameFromFile(kjvBibleMultipleChsAsset);
      expect(bible != null, true);
      expect(bible?.xMLBIBLE != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first.cHAPTER != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first.cHAPTER.first != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first.cHAPTER.first.vERS != null, true);
    });
    test('serializes kjvBibleMultipleChsAsset successfully', () async {
      Bible? bible = await bibleService.loadAssetByNameFromFile(kjvSingleChapterBibleAsset);
      expect(bible != null, true);
      expect(bible?.xMLBIBLE != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first.cHAPTER != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first.cHAPTER.first != null, true);
      expect(bible?.xMLBIBLE?.bIBLEBOOK.first.cHAPTER.first.vERS != null, true);
    });
  });
}