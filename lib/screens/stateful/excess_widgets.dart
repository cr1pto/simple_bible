import 'package:flutter/material.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/shared_app_settings.dart';
import 'package:simple_bible/services/log.service.dart';

class ExcessWidgets extends StatefulWidget {
  const ExcessWidgets({required Key key}) : super(key: key);

  @override
  _ExcessWidgetsState createState() => _ExcessWidgetsState();
}

class _ExcessWidgetsState extends State<ExcessWidgets> {
  SPSettings settings = getIt();
  LogService logService = getIt();
  int settingColor = 0;
  double fontSize = 0.0;
  String fontType = 'roboto';


  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

  List<DropdownMenuItem<String>> getFontTypes() {
    List<DropdownMenuItem<String>> items = [];
    items = List.of(
      SharedAppSettings().fontTypeNames.map(
            (fontTypeForItem) {
          DropdownMenuItem<String> item = DropdownMenuItem(
              value: fontTypeForItem, child: Text(fontTypeForItem));
          return item;
        },
      ),
    );

    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];

    items = List.of(
      SharedAppSettings().fontSizes.map(
            (fontSizeForItem) => DropdownMenuItem(
          value: fontSizeForItem.size.toString(),
          child: Text(fontSizeForItem.name),
        ),
      ),
    );

    return items;
  }

  // void toggleDarkMode(bool isDark) {
  //   logService.info(isDark.toString());
  //   settings.setBrightness(isDark).then((value) {
  //     setState(() {
  //       widget.appSettings.currentBrightness = settings.getBrightness();
  //       widget.appSettings.isDarkModeOn = Brightness.dark.name == widget.appSettings.currentBrightness.name;
  //     });
  //   });
  // }

  void changeSize(String? newSize) {
    settings.setFontSize(double.parse(newSize ?? '12'));
    setState(() {
      fontSize = double.parse(newSize ?? '12');
    });
  }

  void changeFontType(String? newFontType) {
    settings.setFontType(newFontType ?? 'courier');
    setState(() {
      fontType = newFontType ?? 'courier';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
