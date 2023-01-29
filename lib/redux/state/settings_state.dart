import 'package:flutter/material.dart';

//the state itself that we want to define in the store
@immutable
class SettingsState {
  final int fontWeightIndex;
  final String fontStyleName;
  final int settingColor;
  final double fontSize;
  final String fontType;
  final bool isDarkModeOn;

  // final FontWeight fontWeight = FontWeight.w300;
  // FontStyle fontStyle = FontStyle.normal;
  // int settingColor = 0xff1976d2;
  // double fontSize = 16;
  // String fontType = 'courier';
  // bool isDarkModeOn = false;
  // Brightness currentBrightness = Brightness.dark;
  const SettingsState(this.fontWeightIndex, this.fontStyleName, this.settingColor, this.fontSize, this.fontType, this.isDarkModeOn);

  static SettingsState initialState() {
    return const SettingsState(0, "normal", 0, 14, "roboto", true);
  }


}