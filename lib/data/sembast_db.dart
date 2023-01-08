import 'package:injectable/injectable.dart';
import 'package:simple_bible/models/bible_verse.dart';
import 'package:simple_bible/models/password.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

@Singleton()
class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? _db;
  final passwordStore = intMapStoreFactory.store('passwords');
  final verseStore = intMapStoreFactory.store('verses');
  static final SembastDb _singleton = SembastDb._internal();

  SembastDb._internal();

  factory SembastDb() {
    return _singleton;
  }

  static SembastDb getInstance() {
    return SembastDb();
  }

  Future<Database> init() async {
    //_db must be nullable in order to check for null because it's a late variable. Can't mark as late
    Database db;

    _db ??= await _openDb();
    db = _db!;

    return db;
  }

  Future<Database> _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory(); //pathprovider
    final dbPath = join(docsDir.path, 'pass.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addPassword(Password password) async {
    Database db = await init();
    int id = await passwordStore.add(db, password.toMap());
    return id;
  }

  Future<List<Password>> getPasswords() async {
    Database db = await init();
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshot = await passwordStore.find(db, finder: finder);
    final mappings = snapshot.map(createPasswordMap).toList();

    return mappings;
  }

  Future updatePassword(Password pwd) async {
    Database db = await init();
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await passwordStore.update(db, pwd.toMap(), finder: finder);
  }

  Future deletePassword(Password pwd) async {
    Database db = await init();
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await passwordStore.delete(db, finder: finder);
  }

  Future deleteAll() async {
    Database db = await init();
    await passwordStore.delete(db);
  }

  Future<int> addVerse(Database db, BibleVerse verse) async {
    int id = await verseStore.add(db, verse.toMap());
    return id;
  }

  Future<List<BibleVerse>> getVerses(Database db) async {
    final finder = Finder(sortOrders: [SortOrder('id')]);
    final snapshot = await verseStore.find(db, finder: finder);
    final mappings = snapshot.map(createVerseMap).toList();

    return mappings;
  }

  Future<BibleVerse> getVerse(Database db) async {
    final finder = Finder(sortOrders: [SortOrder('id')]);
    final snapshot = await verseStore.find(db, finder: finder);
    final verse = snapshot.map(createVerseMap).toList()[0];

    return verse;
  }

  Future clearAllVerses(Database db) async {
    await verseStore.delete(db);
  }

  Password createPasswordMap(RecordSnapshot<int, Map<String, Object?>> item) {
    final pwd = Password.fromMap(item.value);
    pwd.id = item.key;
    return pwd;
  }

  BibleVerse createVerseMap(RecordSnapshot<int, Map<String, Object?>> item) {
    final verse = BibleVerse.fromMap(item.value);
    verse.id = item.key;
    return verse;
  }

  Future<bool> passwordExists(String name) async {
    Database db = await init();
    var finder = Finder(
        filter: Filter.equals('name', name), sortOrders: [SortOrder('name')]);
    var records = await passwordStore.find(db, finder: finder);

    return records.isNotEmpty && records.first.value.containsValue(name);
  }
}
