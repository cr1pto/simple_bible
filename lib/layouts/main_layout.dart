import 'package:flutter/material.dart';
import 'package:simple_bible/data/shared_prefs.dart';

import '../shared/menu_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
    required this.child,
    this.title,
    this.drawer = true,
    this.floatingBack = false,
    this.floatingBackHero,
  });

  final Widget child;
  final String? title;
  final bool drawer;
  final bool floatingBack;
  final String? floatingBackHero;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int settingColor = 0xff1976d2;

  double fontSize = 16;

  SPSettings settings = SPSettings();

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
    return Scaffold(
      appBar: widget.title != null
          ? AppBar(
              backgroundColor: Color(settingColor),
              title: Text(widget.title!),
            )
          : null,
      drawer: MenuDrawer(
        color: Color(settingColor),
        fontSize: fontSize,
      ),
      floatingActionButton: widget.floatingBack
          ? FloatingActionButton(
              backgroundColor: Color(settingColor),
              heroTag: widget.floatingBackHero ?? "main-layout-back",
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_circle_left),
            )
          : null,
      body: widget.child,
    );
  }
}
