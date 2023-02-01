import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/actions/bible_actions.dart';
import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';
import 'package:simple_bible/screens/stateless/home_options_screen.dart';

@Injectable()
class MaterialRoot extends StatefulWidget {
  MaterialRoot({super.key});

  @override
  _MaterialRootState createState() => _MaterialRootState();
}

class _MaterialRootState extends State<MaterialRoot> {
  final Store<BibleAppState> store = getIt();
  @override
  void initState() {
    setState(() {
      store.dispatch(fetchSettings);
      store.dispatch(loadBible);
    });
    super.initState();
  }

  Widget getApp() {
    return StoreConnector<BibleAppState, SettingsState>(
      converter: (store) => store.state.settingsState,
      builder: (ctx, state) {
        return MaterialApp(
          theme: state.isDarkModeOn ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
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
