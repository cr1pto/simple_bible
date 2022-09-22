import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simple_bible/models/bible.dart';

class BibleService {
  String kjvBibleAsset = 'assets/bibles/kjv.json';

  Future<Bible?> loadAsset() async {
    String jsonText = await rootBundle.loadString(kjvBibleAsset);
    Map<String, Object?> bibleMap = json.decode(jsonText);
    Bible bible = Bible.fromMap(bibleMap);
    return bible;
  }
}
