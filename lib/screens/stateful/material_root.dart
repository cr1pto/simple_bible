import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/home_options_screen.dart';

class MaterialRoot extends StatefulWidget {
  const MaterialRoot({super.key});

@override
  _MaterialRootState createState() => _MaterialRootState();
}

class _MaterialRootState extends State<MaterialRoot> {
  Widget getMaterialApp() {
    return StoreConnector<BibleAppState, BibleAppState>(
        converter: (store) => store.state,
        builder: (_, state) {
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
    return getMaterialApp();
  }
}
