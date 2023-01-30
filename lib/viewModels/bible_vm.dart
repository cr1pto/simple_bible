import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';

class BibleVm {
  final BibleInfo bibleInfo;
  final Bible bible;

  BibleVm(this.bibleInfo, this.bible);

  static initial() {
    return BibleVm(BibleInfo.empty(), Bible.empty());
  }
}