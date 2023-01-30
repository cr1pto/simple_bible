import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

class BibleReducers {
  BibleAppState reducer(BibleAppState prev, dynamic action) {
    if (action is FetchVerseLookupAction) {
      return BibleAppState();
    }
    else if(action is LoadBibleAction) {
      if(prev.bibleState.bibleVm?.bible?.books != null && prev.bibleState.bibleVm!.bible.books.length > 1) return prev;
      BibleAppState appState = BibleAppState.bibleState(bibleState: BibleState.bible(action.bibleVm));
      return appState;
    }
    else if(action is FetchBibleVmAction) {
      if(prev.bibleState.bibleVm?.bible?.books != null && prev.bibleState.bibleVm!.bible.books.length > 1) return prev;
      BibleAppState appState = BibleAppState.bibleState(bibleState: BibleState.bible(action.bibleVm));

      return appState;
    }
    else if(action is FetchSettingsAction) {
      SettingsState settingsState = SettingsState(action.fontWeightIndex, action.fontStyleName, action.settingColor, action.fontSize, action.fontType, action.isDarkModeOn);
      BibleAppState appState = prev;
      appState.settingsState = settingsState;
      return appState;
    }
    else if(action is UpdateColorAction) {
      BibleAppState appState = prev;
      SettingsState settingsState = prev.settingsState;
      settingsState.updateColor(action.settingColor);
      appState.settingsState = settingsState;
      return appState;
    }
    else {
      return prev;
    }
  }
}