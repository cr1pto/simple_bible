// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/bible_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class HomeScreen extends StatefulWidget {
  final BibleService bibleService = BibleService();

  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  Bible? bible;
  List<BIBLEBOOK> books = [];

  @override
  void initState() {
    settings.init().then((value) async {
      try{
        bible = await widget.bibleService.loadAsset();
      }
      catch(error) {
        stderr.writeln(error);
      }
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        books = widget.bibleService.getBooksFromBible(bible);
      });
    });
    super.initState();
  }

  Future getSettings() async {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSettings(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Color(settingColor),
              //   title: const Text('Simple Bible'),
              // ),
              drawer: const MenuDrawer(),
              body: BibleScreen()
              );
        });
  }
}
