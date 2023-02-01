// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    SettingsState(
      fontWeightIndex: json['fontWeightIndex'] as int,
      fontStyleName: json['fontStyleName'] as String,
      settingColor: json['settingColor'] as int,
      fontSize: (json['fontSize'] as num).toDouble(),
      fontType: json['fontType'] as String,
      isDarkModeOn: json['isDarkModeOn'] as bool,
    );

Map<String, dynamic> _$SettingsStateToJson(SettingsState instance) =>
    <String, dynamic>{
      'fontWeightIndex': instance.fontWeightIndex,
      'fontStyleName': instance.fontStyleName,
      'settingColor': instance.settingColor,
      'fontSize': instance.fontSize,
      'fontType': instance.fontType,
      'isDarkModeOn': instance.isDarkModeOn,
    };
