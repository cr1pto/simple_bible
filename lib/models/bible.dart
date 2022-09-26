class BibleInfo {
  List<BibleInfoVersion> versions = <BibleInfoVersion>[];
  List<BibleInfoBook> books = <BibleInfoBook>[];

  BibleInfo(this.versions, this.books);

  BibleInfo.fromMap(Map<String, dynamic> json)
      : versions = (json["versions"] as List<dynamic>)
            .map((v) => BibleInfoVersion.fromMap(v))
            .toList(),
        books = (json["books"] as List<dynamic>)
            .map((v) => BibleInfoBook.fromMap(v))
            .toList();

  Map<String, dynamic> toMap() {
    return {
      'versions': versions.map((v) => v.toMap()),
      'books': books.map((b) => b.toMap()),
    };
  }
}

class BibleInfoVersion {
  String name;
  String abbr;
  String language;

  BibleInfoVersion(
    this.name,
    this.abbr,
    this.language,
  );

  BibleInfoVersion.fromMap(dynamic json)
      : name = json["name"],
        abbr = json["abbr"],
        language = json["language"];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abbr': abbr,
      'language': language,
    };
  }
}

class BibleInfoBook {
  int index;
  String name;
  String abbr;
  int chapterCount;
  String testament;

  BibleInfoBook(
    this.index,
    this.name,
    this.abbr,
    this.chapterCount,
    this.testament,
  );

  BibleInfoBook.fromMap(dynamic json)
      : index = json["index"],
        name = json["name"],
        abbr = json["abbr"],
        chapterCount = json["chapterCount"],
        testament = json["testament"];

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'name': name,
      'abbr': abbr,
      'chapterCount': chapterCount,
      'testament': testament,
    };
  }
}

class Bible {
  String version;
  List<BibleBook> books = <BibleBook>[];

  Bible(this.version, this.books);

  Bible.fromMap(this.version, List<dynamic> jsonList) {
    for (final i in jsonList) {
      int bookNo, chapterNo, verseNo;
      BibleBook book;
      BibleChapter chapter;

      bookNo = int.parse((i['n'] as String).substring(0, 2));
      chapterNo = int.parse((i['n'] as String).substring(2, 5));
      verseNo = int.parse((i['n'] as String).substring(5, 8));

      if (books.where((b) => b.index == bookNo).isEmpty) {
        books.add(BibleBook(bookNo, <BibleChapter>[]));
      }
      book = books.firstWhere((b) => b.index == bookNo);

      if (book.chapters.where((c) => c.index == chapterNo).isEmpty) {
        book.chapters.add(BibleChapter(chapterNo, <BibleVerse>[]));
      }
      chapter = book.chapters.firstWhere((b) => b.index == chapterNo);
      chapter.verses.add(BibleVerse(verseNo, i['t']));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'books': books.map((b) => b.toMap()),
    };
  }
}

class BibleBook {
  int index;
  List<BibleChapter> chapters = <BibleChapter>[];

  BibleBook(
    this.index,
    this.chapters,
  );

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'chapters': chapters.map((v) => v.toMap()),
    };
  }
}

class BibleChapter {
  int index;
  List<BibleVerse> verses = <BibleVerse>[];

  BibleChapter(
    this.index,
    this.verses,
  );

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'verses': verses.map((v) => v.toMap()),
    };
  }
}

class BibleVerse {
  int index;
  String text;

  BibleVerse(
    this.index,
    this.text,
  );

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'text': text,
    };
  }
}
