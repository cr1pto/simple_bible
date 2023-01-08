import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/models/bible_info_book.dart';
import 'package:simple_bible/models/bibleinfo.dart';
import 'package:simple_bible/screens/books_screen.dart';
import 'package:simple_bible/services/bible.service.dart';
import 'package:simple_bible/services/log.service.dart';

@Injectable()
class BibleScreen extends StatefulWidget {
  final SPSettings settings = getIt();

  BibleScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BibleScreenState createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;

  @override
  void initState() {
    widget.settings.init().then((value) async {
      setState(() {
        settingColor = widget.settings.getColor();
        fontSize = widget.settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Bible',
      floatingBack: true,
      floatingBackHero: 'home-back',
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          if (state is BibleLoaded) {
            return BooksScreen(bibleInfo: state.info, bible: state.bible);
          }
          return Container();
        },
      ),
    );
  }
}
