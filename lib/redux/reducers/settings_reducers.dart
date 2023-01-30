import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

class SettingsReducers {
  //the reducer to reduce the state; i.e., return the state that we care about.   The dynamic property is an action.
  SettingsState reducer(BibleAppState prev, dynamic action) {
    if (action is FetchSettingsAction) {
      return SettingsState(action.fontWeightIndex, action.fontStyleName, action.settingColor, action.fontSize, action.fontType, action.isDarkModeOn);
    }
    else if(action is UpdateColorAction) {
      return prev.settingsState;
    }
    else {
      return prev.settingsState;
    }
  }
}