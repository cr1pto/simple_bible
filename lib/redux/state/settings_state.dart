import 'package:flutter/material.dart';

//the state itself that we want to define in the store
// @immutable
class SettingsState {
  int fontWeightIndex;
  String fontStyleName;
  int settingColor;
  double fontSize;
  String fontType;
  bool isDarkModeOn;

  // final FontWeight fontWeight = FontWeight.w300;
  // FontStyle fontStyle = FontStyle.normal;
  // int settingColor = 0xff1976d2;
  // double fontSize = 16;
  // String fontType = 'courier';
  // bool isDarkModeOn = false;
  // Brightness currentBrightness = Brightness.dark;
  SettingsState(this.fontWeightIndex, this.fontStyleName, this.settingColor, this.fontSize, this.fontType, this.isDarkModeOn);
  SettingsState.state(SettingsState state) : this(state.fontWeightIndex, state.fontStyleName, state.settingColor, state.fontSize, state.fontType, state.isDarkModeOn);

  void updateColor(int newColor) {
    settingColor = newColor;
  }

  static SettingsState initialState() {
    return SettingsState(0, "normal", 0, 14, "roboto", true);
  }


}