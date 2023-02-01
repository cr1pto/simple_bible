import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_state.g.dart';

//the state itself that we want to define in the store
@immutable
@JsonSerializable()
class SettingsState {
  int fontWeightIndex = 0;
  String fontStyleName = "";
  int settingColor = 0;
  double fontSize = 0.0;
  String fontType = "";
  bool isDarkModeOn = true;

  // final FontWeight fontWeight = FontWeight.w300;
  // FontStyle fontStyle = FontStyle.normal;
  // int settingColor = 0xff1976d2;
  // double fontSize = 16;
  // String fontType = 'courier';
  // bool isDarkModeOn = false;
  // Brightness currentBrightness = Brightness.dark;
  SettingsState({required this.fontWeightIndex, required this.fontStyleName, required this.settingColor, required this.fontSize, required this.fontType, required this.isDarkModeOn});
  SettingsState.initial();
  SettingsState.state(SettingsState state) : this(fontWeightIndex: state.fontWeightIndex, fontStyleName: state.fontStyleName, settingColor: state.settingColor, fontType: state.fontType, fontSize: state.fontSize, isDarkModeOn: state.isDarkModeOn);

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);
}