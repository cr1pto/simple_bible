// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/models/note.dart';

class MemoScreen extends StatefulWidget {
  const MemoScreen({Key? key}) : super(key: key);

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  SPSettings settings = SPSettings();
  final String titleText = 'Memos';
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  String fontType = 'courier';
  List<Note> notes = <Note>[];

  String networkSettingsText = '';

  @override
  void initState() {
    settings.init().then((value) async {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        fontType = settings.getFontType();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titleText),
          backgroundColor: Color(settingColor),
        ),
        // drawer: const MenuDrawer(),
        // floatingActionButton: FloatingActionButton(
        //     child: const Icon(Icons.add),
        //     backgroundColor: Color(settingColor),
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (context) {
        //             Password pwd = Password('', '');
        //             return PasswordDetailDialog(pwd, true, sembastDb);
        //           }
        //       );
        //     }
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildNotes(),
          // child: Text(networkSettingsText, style: TextStyle(fontSize: fontSize, fontFamily: fontType)),
        ));
  }

  buildNotes() {
    notes.add(Note('', ''));
    return ListView();
  }
}
