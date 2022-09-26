// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/components/color_square.dart';
import 'package:simple_bible/layouts/main_layout.dart';

import '../data/shared_prefs.dart';
import '../models/font_size.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<DropdownMenuItem<String>> fontSizesItems = [];
  List<DropdownMenuItem<String>> fontTypes = [];
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  String fontType = 'courier';
  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795548
  ];
  SPSettings settings = SPSettings();
  final List<FontSize> fontSizes = [
    FontSize('small', 12),
    FontSize('medium', 16),
    FontSize('large', 20),
    FontSize('extra-large', 24),
  ];

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

  @override
  void initState() {
    settings.init().then((value) => {
          setState(() {
            settingColor = settings.getColor();
            fontSize = settings.getFontSize();
            fontType = settings.getFontType();
            fontSizesItems = getDropDownMenuItems();
            fontTypes = getFontTypes();
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Settings',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Choose a Font Size for the app',
              style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: fontType,
                  color: Color(settingColor))),
          DropdownButton(
              value: fontSize.toString(),
              items: fontSizesItems,
              onChanged: changeSize),
          Text('Choose a Font Type for the app',
              style: TextStyle(
                  fontSize: fontSize,
                  fontStyle: FontStyle.normal,
                  fontFamily: fontType,
                  color: Color(settingColor))),
          DropdownButton(
              value: fontType, items: fontTypes, onChanged: changeFontType),
          Text('App Main Color',
              style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: fontType,
                  color: Color(settingColor))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(color: Color(colors[0])),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(color: Color(colors[1])),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(color: Color(colors[2])),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(color: Color(colors[3])),
              ),
              GestureDetector(
                onTap: () => setColor(colors[4]),
                child: ColorSquare(color: Color(colors[4])),
              ),
            ],
          )
        ],
      ),
    );
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

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
}
