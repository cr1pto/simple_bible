import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/home_options_screen.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class MaterialRoot extends StatefulWidget {
  MaterialRoot({super.key});

  @override
  _MaterialRootState createState() => _MaterialRootState();
}

class _MaterialRootState extends State<MaterialRoot> {
  BibleService bibleService = getIt();
  Widget getApp() {
    return StoreConnector<BibleAppState, BibleAppState>(
      converter: (store) {
        if(store.state.bibleState.bibleVm?.bible != null && store.state.bibleState.bibleVm!.bible.books.length > 1) return store.state;
        store.dispatch(fetchSettings);
        return store.dispatch(loadBible);
      },
      builder: (ctx, state) {
        return MaterialApp(
          theme: state.settingsState.isDarkModeOn ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
          home: MainLayout(
              child: HomeOptionsScreen()
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return getApp();
  }
}
