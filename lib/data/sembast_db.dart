import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/password.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';

@Singleton()
class SembastDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database db;
  final passwordStore = intMapStoreFactory.store('passwords');
  final verseStore = intMapStoreFactory.store('verses');

  Future<Database> createDb() async {
    final docsDir = await getApplicationDocumentsDirectory(); //pathprovider
    final dbPath = join(docsDir.path, 'pass.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addPassword(Password password) async {
    int id = await passwordStore.add(db, password.toMap());
    return id;
  }

  Future<List<Password>> getPasswords() async {
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshot = await passwordStore.find(db, finder: finder);
    final mappings = snapshot.map(createPasswordMap).toList();

    return mappings;
  }

  Future updatePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await passwordStore.update(db, pwd.toMap(), finder: finder);
  }

  Future deletePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await passwordStore.delete(db, finder: finder);
  }

  Future deleteAll() async {
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
    var finder = Finder(
        filter: Filter.equals('name', name), sortOrders: [SortOrder('name')]);
    var records = await passwordStore.find(db, finder: finder);

    return records.isNotEmpty && records.first.value.containsValue(name);
  }
}
