import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:simple_bible/injection.dart';

@Injectable()
class SPSettings {
  final String fontSizeKey = 'font_size';
  final String fontTypeKey = 'font_type';
  final String colorKey = 'color';
  final String brightnessKey = 'brightness';
  final String fontStyleKey = 'fontStyle';
  final String fontWeightKey = 'fontWeight';
  SharedPreferences _sp = getIt();
  static SPSettings? _instance;

  SPSettings.internal();

  // factory constructor that allows you to return something from a constructor
  factory SPSettings() {
    _instance ??= SPSettings.internal();
    return _instance as SPSettings;
  }

  Future init() async {
    _sp = await SharedPreferences.getInstance();
  }

  Future setColor(int color) {
    return _sp.setInt(colorKey, color);
  }

  int getColor() {
    int? color = _sp.getInt(colorKey);

    color ??= 0xff1976d2;
    return color;
  }

  Future setFontSize(double size) {
    return _sp.setDouble(fontSizeKey, size);
  }

  double getFontSize() {
    double? fontSize = _sp.getDouble(fontSizeKey);

    fontSize ??= 12;
    return fontSize;
  }

  String getFontType() {
    String? fontType = _sp.getString(fontTypeKey);

    fontType ??= 'courier';

    return fontType;
  }
  Future setFontType(String fontType) async {
    await _sp.setString(fontTypeKey, fontType);
  }

  Future setBrightness(bool isDark) {
    return _sp.setBool(brightnessKey, isDark);
  }

  Brightness getBrightness() {
    bool isDark = _sp.getBool(brightnessKey) ?? true;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    return brightness;
  }

  Future setStyle(FontStyle style) {
    return _sp.setString(fontStyleKey, style.name);
  }

  FontStyle getStyle() {
    String? style = _sp.getString(fontStyleKey);

    if(style != null && FontStyle.italic.name == style) return FontStyle.italic;

    return FontStyle.normal;
  }

  Future setFontWeight(String weight) {
    return _sp.setString(fontWeightKey, weight);
  }

  FontWeight getFontWeight() {
    String? fontWeight = _sp.getString(fontWeightKey);
    if(fontWeight == null) return FontWeight.w300;

    FontWeight weight = FontWeight.values.firstWhere((element) => fontWeight == element.toString());

    return weight;
  }
}
