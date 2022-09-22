import 'package:flutter/material.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/screens/passwords.dart';
import 'package:simple_bible/screens/settings.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();

  @override
  void initState() {
    getSettings();
    super.initState();
  }

  Future getSettings() async {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSettings(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(settingColor),
                title: const Text('GlobApp'),
              ),
              drawer: const MenuDrawer(),
              body: const Text('Welcome!')
              // body: Container(
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/travel.jpg')
              //     )
              //   ),
              // ),
              );
        });
  }
}
