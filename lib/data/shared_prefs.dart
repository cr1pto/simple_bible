import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:simple_bible/injection.dart';

@Injectable()
class SPSettings {
  final String fontSizeKey = 'font_size';
  final String fontTypeKey = 'font_type';
  final String colorKey = 'color';
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
}
