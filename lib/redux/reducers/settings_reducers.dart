import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

class SettingsReducers {
  //the reducer to reduce the state; i.e., return the state that we care about.   The dynamic property is an action.
  SettingsState reducer(BibleAppState prev, dynamic action) {
    if (action is FetchSettingsAction) {
      return SettingsState.state(action as SettingsState);
    }
    else if(action is UpdateColorAction) {
      return SettingsState(fontWeightIndex: prev.settingsState.fontWeightIndex, fontStyleName: prev.settingsState.fontStyleName, settingColor: action.settingColor, fontSize: prev.settingsState.fontSize, fontType: prev.settingsState.fontType, isDarkModeOn: prev.settingsState.isDarkModeOn);
    }
    else {
      return prev.settingsState;
    }
  }
}