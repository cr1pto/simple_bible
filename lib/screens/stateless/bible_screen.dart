import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/books_screen.dart';

@Injectable()
class BibleScreen extends StatelessWidget {
  BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Bible',
      floatingBack: true,
      floatingBackHero: 'home-back',
      child: StoreConnector<BibleAppState, BibleState>(
        converter: (store) => store.state.bibleState,
        builder: (context, state) {
          return const BooksScreen();
        },
      ),
    );
  }
}
