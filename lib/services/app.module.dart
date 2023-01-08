import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

@module
abstract class AppModule {
  // @preResolve
  // Future<FirebaseService> get fireService => FirebaseService.init();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  //todo: add sembast

  // @lazySingleton
  // LogService get logService => LogService.getInstance();

  // @injectable
  // SembastDb get sembastDb => SembastDb.getInstance();

  // @lazySingleton
  // BibleService get bibleService => BibleService.getInstance();
}
