import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simple_bible/models/bible.dart';

class BibleService {
  String infoAsset = 'assets/bibles/info.json';
  String kjvAsset = 'assets/bibles/basic/kjv.json';

  Future<BibleInfo> loadInfo() async {
    String jsonText = await rootBundle.loadString(infoAsset);
    Map<String, dynamic> bibleInfoMap = json.decode(jsonText);
    return BibleInfo.fromMap(bibleInfoMap);
  }

  Future<Bible> loadKJV() async {
    String jsonText = await rootBundle.loadString(kjvAsset);
    List<dynamic> bibleMap = json.decode(jsonText);
    return Bible.fromMap("kjv", bibleMap);
  }
}
