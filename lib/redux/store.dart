import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/redux/middleware.dart';
import 'package:simple_bible/redux/reducers/bible_reducers.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';

@Singleton()
class BibleStore{
  Future<Store<BibleAppState>> initializeStore() async {
     final initialState = await _loadState();
    Store<BibleAppState> store = Store(
      BibleReducers().appReducer,
      initialState: initialState,
      middleware: createMiddleware(),
    );

    return store;
  }

  Future<BibleAppState> _loadState() async {
    try {
      final BibleAppState? initialState = await persistor.load();
      return initialState ?? BibleAppState();
    } on Exception {
      // Re-hydration error
      return BibleAppState();
    }
  }
}