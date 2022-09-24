import 'package:simple_bible/exceptions/bible_serialization_exception.dart';

class Bible {
  XMLBIBLE? xMLBIBLE;

  Bible(this.xMLBIBLE);

  Bible.fromMap(Map<String, dynamic> map) {
    xMLBIBLE = XMLBIBLE.fromMap(map['XMLBIBLE']);
  }

  Map<String, dynamic> toMap() {
    return {
      'XMLBIBLE': xMLBIBLE?.toMap()
    };
  }
}

class XMLBIBLE {
  INFORMATION? iNFORMATION;
  List<BIBLEBOOK> bIBLEBOOK = <BIBLEBOOK>[];
  String? sXmlnsXsi;
  String? sBiblename;
  String? sXsiNoNamespaceSchemaLocation;

  XMLBIBLE(
      this.iNFORMATION,
      this.bIBLEBOOK,
        this.sXmlnsXsi,
        this.sBiblename,
        this.sXsiNoNamespaceSchemaLocation);

  XMLBIBLE.fromMap(Map<String, dynamic> map) {
    iNFORMATION = INFORMATION.fromMap(map['INFORMATION']);

    if(map['BIBLEBOOK'] != null) {
      map['BIBLEBOOK'].forEach((b) => bIBLEBOOK.add(BIBLEBOOK.fromMap(b)));
    }

    sXmlnsXsi = map['_xmlns:xsi'];
    sBiblename = map['_biblename'];
    sXsiNoNamespaceSchemaLocation = map['_xsi:noNamespaceSchemaLocation'];
  }

  Map<String, dynamic> toMap() {
    return {
      'INFORMATION': iNFORMATION?.toMap(),
      'BIBLEBOOK': bIBLEBOOK.map((e) => e.toMap()),
      '_xmlns:xsi': sXmlnsXsi,
      '_biblename': sBiblename,
      '_xsi:noNamespaceSchemaLocation': sXsiNoNamespaceSchemaLocation
    };
  }
}

class INFORMATION {
  String? title;
  String? contributors;
  String? subject;
  String? creator;
  String? description;
  String? publisher;
  String? format;
  String? language;
  String? identifier;
  String? date;
  String? source;
  String? type;
  String? rights;
  String? coverage;

  INFORMATION(
      this.title,
        this.contributors,
        this.subject,
        this.creator,
        this.description,
        this.publisher,
        this.format,
        this.language,
        this.identifier,
        this.date,
        this.source,
        this.type,
        this.rights,
        this.coverage);

  INFORMATION.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    contributors = map['contributors'];
    subject = map['subject'];
    creator = map['creator'];
    description = map['description'];
    publisher = map['publisher'];
    format = map['format'];
    language = map['language'];
    identifier = map['identifier'];
    date = map['date'];
    source = map['source'];
    type = map['type'];
    rights = map['rights'];
    coverage = map['coverage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contributors': contributors,
      'subject': subject,
      'creator': creator,
      'description': description,
      'publisher': publisher,
      'format': format,
      'language': language,
      'identifier': identifier,
      'date': date,
      'source': source,
      'type': type,
      'rights': rights,
      'coverage': coverage,
    };
  }
}

class BIBLEBOOK {
  List<CHAPTER> cHAPTER = <CHAPTER>[];
  String? sBnumber;
  String? sBname;
  String? sBsname;

  BIBLEBOOK(this.cHAPTER, this.sBnumber, this.sBname, this.sBsname);

  BIBLEBOOK.fromMap(Map<String, dynamic> map) {
    sBnumber = map['_bnumber'];
    sBname = map['_bname'];
    sBsname = map['_bsname'];
    try{
      if(map['CHAPTER'] is! List){
        CHAPTER ch = CHAPTER.fromSingleChapterMap(map['CHAPTER']);
        cHAPTER.add(ch);
        return;
      }
      map['CHAPTER'].forEach((c) {
        CHAPTER ch = CHAPTER.fromMap(c);
        if(ch.vERS.isEmpty) {
          throw BibleSerializationException(null, null, ch, null);
        }
        cHAPTER.add(ch);
      });
    }
    catch(error) {
      map['CHAPTER'].forEach((c, v) {
        CHAPTER ch = CHAPTER.fromMap(map);
        if(ch.vERS.isEmpty) {
          throw BibleSerializationException(null, null, ch, null);
        }
        cHAPTER.add(ch);
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'CHAPTER': cHAPTER.map((v) => v.toMap()),
      '_bnumber': sBnumber,
      '_bname': sBname,
      '_bsname': sBsname,
    };
  }
}

class CHAPTER {
  List<VERS> vERS = <VERS>[];
  String? sCnumber;

  CHAPTER(this.vERS, this.sCnumber);

  CHAPTER.fromMap(Map<String, dynamic> map) {
    sCnumber = map['_cnumber'];
    if(map['VERS'] != null) {
      map['VERS'].forEach((v) => vERS.add(VERS.fromMap(v)));
    }
  }

  CHAPTER.fromSingleChapterMap(Map<String, dynamic> map) {
    sCnumber = '1';
    if(map['VERS'] != null) {
      map['VERS'].forEach((v) => vERS.add(VERS.fromMap(v)));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'VERS': vERS.map((v) => v.toMap()),
      '_cnumber': sCnumber
    };
  }

  Map<String, dynamic> toSingleChapterMap() {
    return {
      'VERS': vERS.map((v) => v.toMap()),
      '_cnumber': sCnumber
    };
  }
}

class VERS {
  String? sVnumber;
  String? sText;

  VERS(this.sVnumber, this.sText);

  VERS.fromMap(Map<String, dynamic> map) {
    sVnumber = map['_vnumber'];
    sText = map['__text'];
  }

  Map<String, dynamic> toMap() {
    return {
      '_vnumber': sVnumber,
      '__text': sText
    };
  }
}