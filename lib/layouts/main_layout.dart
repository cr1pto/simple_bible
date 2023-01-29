import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateless/home_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

@Injectable()
class MainLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  final bool drawer;
  final bool floatingBack;
  final String? floatingBackHero;

  const MainLayout({
    super.key,
    required this.child,
    this.title,
    this.drawer = true,
    this.floatingBack = false,
    this.floatingBackHero,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    MenuDrawer menuDrawer = MenuDrawer();
    return StoreConnector<BibleAppState, BibleAppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Scaffold(
            appBar: widget.title != null
                ? AppBar(
              backgroundColor: Color(state.settingsState.settingColor),
              title: Text(widget.title!),
            )
                : null,
            drawer: menuDrawer,
            floatingActionButton: widget.floatingBack
                ? FloatingActionButton(
              backgroundColor: Color(state.settingsState.settingColor),
              heroTag: widget.floatingBackHero ?? "main-layout-back",
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: const Icon(Icons.arrow_circle_left),
            )
                : null,
            body: widget.child,
          );
        });
  }
}
