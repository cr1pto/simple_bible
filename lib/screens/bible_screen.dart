import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bible/screens/books_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

import '../bloc/bible/bible_bloc.dart';
import '../data/sembast_db.dart';
import '../data/shared_prefs.dart';
import '../layouts/main_layout.dart';

class BibleScreen extends StatefulWidget {
  final BibleService bibleService = BibleService();

  BibleScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BibleScreenState createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  SembastDb sembastDb = SembastDb();

  @override
  void initState() {
    settings.init().then((value) async {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Bible',
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          if (state is BibleLoaded) {
            return BooksScreen(books: state.info.books, bible: state.bible);
          }
          return Container();
        },
      ),
    );
  }
}
