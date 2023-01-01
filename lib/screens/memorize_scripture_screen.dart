import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/services/bible.service.dart';

class MemorizeScriptureScreen extends StatefulWidget {
  MemorizeScriptureScreen({Key? key}) : super(key: key);

  @override
  _MemorizeScriptureScreenState createState() =>
      _MemorizeScriptureScreenState();
  final BibleService bibleService = BibleService();
}

class _MemorizeScriptureScreenState extends State<MemorizeScriptureScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  SembastDb sembastDb = SembastDb();
  Color color = const Color(0x00000000);
  BibleVerse randomBibleVerse = BibleVerse(0, "", 0, 0);
  late BibleInfo bibleInfo;
  late Bible bible;

  @override
  void initState() {
    settings.init().then((value) async {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        color = Color(settingColor);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Memorize Random Scripture',
      floatingBack: true,
      floatingBackHero: "home-back",
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          if (state is BibleLoaded) {
            bibleInfo = state.info; 
            bible = state.bible;
            String text = widget.bibleService.getRandomVerse(bibleInfo, bible);
            return Card(child: Text(text,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 20.0,
                )));
          }
          return Container();
        },
      ),
    );
  }
}
