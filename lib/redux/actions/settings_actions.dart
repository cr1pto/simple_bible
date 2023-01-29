import 'dart:ui';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/redux/state/settings_state.dart';

// typedef FetchSettings = Function();

ThunkAction<SettingsState> fetchSettings = (Store<SettingsState> store) async {
  SPSettings settings = getIt();

  FetchSettingsAction action = FetchSettingsAction(settings.getFontWeight().index, settings.getStyle().name, settings.getColor(), settings.getFontSize(), settings.getFontType(), settings.getBrightness().name == Brightness.dark.name);

  return store.dispatch(action);
};

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