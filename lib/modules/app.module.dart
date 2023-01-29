import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/store.dart';

@module
abstract class AppModule {
  // @preResolve
  // Future<FirebaseService> get fireService => FirebaseService.init();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Store<BibleAppState>> get store => BibleStore().initializeStore();

  @preResolve
  Future<Database> get database => SembastDb().createDb();

  // @lazySingleton
  // LogService get logService => LogService.getInstance();

  // @injectable
  // SembastDb get sembastDb => SembastDb.getInstance();

  // @lazySingleton
  // BibleService get bibleService => BibleService.getInstance();
}
