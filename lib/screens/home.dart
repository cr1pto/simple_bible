// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/screens/home_options_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

class HomeScreen extends StatelessWidget {
  final BibleService bibleService = BibleService();

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: HomeOptionsScreen(),
    );
  }
}
