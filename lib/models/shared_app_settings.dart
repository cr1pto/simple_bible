import 'package:flutter/material.dart';
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

  List<int> colors = [
    // 0xFF455A64,
    //#625D5D
    0x625D5D5D,
    0xD6D5D5D5,
    0xFFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795548
  ];
  List<DropdownMenuItem<String>> fontSizesItems = [];
  List<DropdownMenuItem<String>> fontTypes = [];
}