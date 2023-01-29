import 'package:flutter/material.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/models/font_size.dart';

class SharedAppSettings {
  final List<String> fontTypeNames = [
    'courier',
    'times',
    'roboto',
    'arial',
    'serif', // basically the same thing as times
    'sans-serif', // basically the same thing as roboto
    'comic-sans',
    'poor-richard',
    'mistral',
    'wingdings',
    'calibri',
    'calibre',
    'Raleway' // mac?
  ];
  final List<FontSize> fontSizes = [
    FontSize('small', 12),
    FontSize('medium', 16),
    FontSize('large', 20),
    FontSize('extra-large', 24),
  ];
  final SPSettings settings = getIt();
  List<DropdownMenuItem<String>> getFontTypes() {
    List<DropdownMenuItem<String>> items = [];
    items = List.of(
      fontTypeNames.map(
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
      fontSizes.map(
            (fontSizeForItem) => DropdownMenuItem(
          value: fontSizeForItem.size.toString(),
          child: Text(fontSizeForItem.name),
        ),
      ),
    );

    return items;
  }
  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795548
  ];
  List<DropdownMenuItem<String>> fontSizesItems = [];
  List<DropdownMenuItem<String>> fontTypes = [];

  // void updateCommonAppSettings() {
  //   settingColor = settings.getColor();
  //   fontSize = settings.getFontSize();
  //   fontType = settings.getFontType();
  //   fontSizesItems = getDropDownMenuItems();
  //   fontTypes = getFontTypes();
  //   fontStyle = settings.getStyle();
  //   fontWeight = settings.getFontWeight();
  //   currentBrightness = settings.getBrightness();
  // }

  // void refreshDarkMode() {
  //   isDarkModeOn = Brightness.dark.name == currentBrightness.name;
  // }

  // bool getIsDarkModeOn() {
  //   return isDarkModeOn;
  // }
}