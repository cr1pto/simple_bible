import 'dart:ui';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

ThunkAction<BibleAppState> fetchSettings = (Store<BibleAppState> store) async {
  if(store.state.settingsState.settingColor != 0) {
    return store.dispatch(
      FetchSettingsAction(
        store.state.settingsState.fontWeightIndex,
        store.state.settingsState.fontStyleName,
          store.state.settingsState.settingColor,
          store.state.settingsState.fontSize,
          store.state.settingsState.fontType,
          store.state.settingsState.isDarkModeOn
      )
    );
  }
  SPSettings settings = getIt();

  await settings.init();

  FetchSettingsAction action = FetchSettingsAction(settings.getFontWeight().index, settings.getStyle().name, settings.getColor(), settings.getFontSize(), settings.getFontType(), settings.getBrightness().name == Brightness.dark.name);

  store.dispatch(action);
};

ThunkAction<BibleAppState> updateColor = (Store<BibleAppState> store) {
  UpdateColorAction action = UpdateColorAction(store.state.settingsState!.settingColor);
  store.dispatch(action);
};

class UpdateColorAction {
  final int _settingColor;
  int get settingColor => _settingColor;
  UpdateColorAction(this._settingColor);
}

class UpdateFontSizeAction {
  final double _fontSize;
  double get fontSize => _fontSize;
  UpdateFontSizeAction(this._fontSize);
}

class UpdateFontTypeAction {
  final String _fontType;
  String get fontType => _fontType;
  UpdateFontTypeAction(this._fontType);
}

class UpdateBrightnessAction {
  final bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;
  UpdateBrightnessAction(this._isDarkMode);
}

class FetchSettingsAction {
  final int _fontWeightIndex;
  final String _fontStyleName;
  final int _settingColor;
  final double _fontSize;
  final String _fontType;
  final bool _isDarkModeOn;

  int get fontWeightIndex => _fontWeightIndex;
  String get fontStyleName => _fontStyleName;
  int get settingColor => _settingColor;
  double get fontSize => _fontSize;
  String get fontType => _fontType;
  bool get isDarkModeOn => _isDarkModeOn;

  FetchSettingsAction(this._fontWeightIndex, this._fontStyleName, this._settingColor, this._fontSize, this._fontType, this._isDarkModeOn);
}