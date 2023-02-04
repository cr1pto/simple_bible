import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/redux/middleware.dart';
import 'package:simple_bible/redux/reducers/bible_reducers.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/home_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

class TestHelpers {
  Future<GetIt> createContainer() async {
    final GetIt di = GetIt.instance;

    di.registerSingletonAsync<SharedPreferences>(() async {
      SharedPreferences.setMockInitialValues({});
      var sp = await SharedPreferences.getInstance();

      return sp;
    });
    di.registerFactory<SPSettings>((){
      GetIt.instance.get<SharedPreferences>();
      var spSettings = SPSettings();
      return spSettings;
    });
    di.registerSingleton<LogService>(LogService());
    di.registerSingleton<BibleService>(BibleService());
    di.registerSingleton<Store<BibleAppState>>(Store(
      BibleReducers().reducer,
      initialState: BibleAppState.initial(),
      middleware: createMiddleware(),
    ));

    return di;
  }

  static void expectToBeTrue(bool condition) {
    expect(condition, true);
  }

  static void expectToBeFalse(bool condition) {
    expect(condition, false);
  }

  static void expectToBeEqual(dynamic expected, dynamic actual) {
    expectToBeTrue(expected == actual);
  }
}