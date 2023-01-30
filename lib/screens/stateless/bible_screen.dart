import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/books_screen.dart';

@Injectable()
class BibleScreen extends StatelessWidget {
  final SPSettings settings = getIt();

  BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Bible',
      floatingBack: true,
      floatingBackHero: 'home-back',
      child: StoreConnector<BibleAppState, BibleAppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          if(state.bibleState.bibleVm?.bible == null) return Container();

          return BooksScreen(bibleInfo: state.bibleState.bibleVm!.bibleInfo, bible: state.bibleState.bibleVm!.bible);
        },
      ),
    );
  }
}
