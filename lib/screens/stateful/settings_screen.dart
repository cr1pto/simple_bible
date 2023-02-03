import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/components/color_square.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/shared_app_settings.dart';
import 'package:simple_bible/redux/actions/settings_actions.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/settings_state.dart';
import 'package:simple_bible/services/log.service.dart';

@Injectable()
class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Store<BibleAppState> store = getIt();
  SPSettings settings = getIt();
  LogService logService = getIt();

  void toggleDarkMode(bool value) {
    setState(() {
      store.dispatch(UpdateBrightnessAction(value));
      store.dispatch(updateBrightness);
    });
  }

  void changeSize(String? fontSize) {
    double newSize = double.parse(fontSize!);
    setState(() {
      store.dispatch(UpdateFontSizeAction(newSize));
      store.dispatch(updateFontSize);
    });
  }

  void changeFontType(String? fontType) {
    setState(() {
      store.dispatch(UpdateFontTypeAction(fontType!));
      store.dispatch(updateFontType);
    });
    setState(() {

    });
  }

  void setColor(int color) {
    setState(() {
      store.dispatch(UpdateColorAction(color));
      store.dispatch(updateColor);
    });
  }

  Widget getAll(SettingsState state) {
    return MainLayout(
      title: 'Settings',
      floatingBack: true,
      floatingBackHero: "home-back",
      drawer: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Turn on Dark Mode',
              style: TextStyle(
                fontSize: state.fontSize,
                fontWeight: FontWeight.values.firstWhere((
                    element) => state.fontWeightIndex == element.index),
                fontFamily: state.fontType,
              )),
          Switch(
              value: state.isDarkModeOn,
              onChanged: toggleDarkMode
          ),
          Text('Choose a Font Size for the app',
              style: TextStyle(
                fontSize: state.fontSize,
                fontWeight: FontWeight.values.firstWhere((
                    element) => state.fontWeightIndex == element.index),
                fontFamily: state.fontType,
              )),
          DropdownButton(
              value: state.fontSize.toString(),
              items: SharedAppSettings().getFontSizeItems(),
              onChanged: changeSize),
          Text('Choose a Font Type for the app',
              style: TextStyle(
                fontSize: state.fontSize,
                fontStyle: FontStyle.values.firstWhere((element) => state.fontStyleName == element.name),
                fontWeight: FontWeight.values.firstWhere((element) => state.fontWeightIndex == element.index),
                fontFamily: state.fontType,
              )),
          DropdownButton(
              value: state.fontType,
              items: SharedAppSettings().getFontTypes(),
              onChanged: changeFontType),
          Text('App Main Color',
              style: TextStyle(
                fontSize: state.fontSize,
                fontStyle: FontStyle.values.firstWhere((
                    element) => element.name == state.fontStyleName),
                fontWeight: FontWeight.values.firstWhere((
                    element) => state.fontWeightIndex == element.index),
                fontFamily: state.fontType,
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(SharedAppSettings().colors[0]),
                child: ColorSquare(
                    color: Color(SharedAppSettings().colors[0])),
              ),
              GestureDetector(
                onTap: () => setColor(SharedAppSettings().colors[1]),
                child: ColorSquare(
                    color: Color(SharedAppSettings().colors[1])),
              ),
              GestureDetector(
                onTap: () => setColor(SharedAppSettings().colors[2]),
                child: ColorSquare(
                    color: Color(SharedAppSettings().colors[2])),
              ),
              GestureDetector(
                onTap: () => setColor(SharedAppSettings().colors[3]),
                child: ColorSquare(
                    color: Color(SharedAppSettings().colors[3])),
              ),
              GestureDetector(
                onTap: () => setColor(SharedAppSettings().colors[4]),
                child: ColorSquare(
                    color: Color(SharedAppSettings().colors[4])),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getSettings() {
    return StoreConnector<BibleAppState, SettingsState>(
      converter: (store) => store.state.settingsState,
      builder: (context, state) => getAll(state)
    );
  }

  @override
  Widget build(BuildContext context) {
    return  getSettings();
  }
}
