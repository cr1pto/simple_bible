import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';
import 'package:simple_bible/screens/stateless/bible_screen.dart';
import 'package:simple_bible/screens/stateless/home_screen.dart';
import 'package:simple_bible/screens/stateful/settings_screen.dart';

@Injectable()
class MenuDrawer extends StatelessWidget {
  MenuDrawer({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, SettingsState>(
        converter: (store) => store.state.settingsState,
        builder: (_, state) {
          return Drawer(
            backgroundColor: Color(state.settingColor),
            width: 250,
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Simple Bible',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.values.firstWhere((
                            element) => element.name == state.fontStyleName),
                        fontWeight: FontWeight.values.firstWhere((
                            element) => element.index == state.fontWeightIndex),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Home",
                        style: TextStyle(
                          fontStyle: FontStyle.values.firstWhere((
                              element) => element.name == state.fontStyleName),
                          fontWeight: FontWeight.values.firstWhere((
                              element) => element.index == state.fontWeightIndex),
                          fontSize: 20,
                        )
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Bible",
                        style: TextStyle(
                          fontStyle: FontStyle.values.firstWhere((
                              element) => element.name == state.fontStyleName),
                          fontWeight: FontWeight.values.firstWhere((
                              element) => element.index == state.fontWeightIndex),
                          fontSize: 20,
                        )
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => BibleScreen()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                        "Settings",
                        style: TextStyle(
                          fontStyle: FontStyle.values.firstWhere((
                              element) => element.name == state.fontStyleName),
                          fontWeight: FontWeight.values.firstWhere((
                              element) => element.index == state.fontWeightIndex),
                          fontSize: 20,
                        )
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
