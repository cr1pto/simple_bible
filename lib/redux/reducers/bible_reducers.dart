import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';

class BibleReducers {
  BibleAppState appReducer(BibleAppState state, action) {
    return BibleAppState(
      // global: globalReducer(state.global, action),
      // auth: authReducer(state.auth, action),
      // entities: entitiesReducer(state.entities, action),
      // navigation: navigationReducer(state.navigation, action),
    );
  }
  BibleAppState reducer(BibleAppState prev, dynamic action) {
    if (action is FetchVerseLookupAction) {
      return BibleAppState();
    } else {
      return prev;
    }
  }
}