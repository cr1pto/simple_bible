import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/redux/middleware.dart';
import 'package:simple_bible/redux/reducers/bible_reducers.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/viewModels/bible_vm.dart';

@Singleton()
class BibleStore{
  BibleService bibleService = getIt();
  Future<Store<BibleAppState>> initializeStore() async {
    final initialState = await _loadState();
    Store<BibleAppState> store = Store(
      BibleReducers().reducer,
      initialState: initialState,
      middleware: createMiddleware(),
    );

    return store;
  }

  Future<BibleAppState> _loadState() async {
    try {
      final BibleAppState? initialState = await persistor.load();

      BibleVm bibleVm = await bibleService.loadBible();
      return BibleAppState.bibleState(bibleState: BibleState.bible(bibleVm));
      // return initialState ?? BibleAppState();
    } on Exception {
      // Re-hydration error
      return BibleAppState();
    }
  }
}