import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/screens/stateful/material_root.dart';

@Injectable()
class HomeScreen extends StatelessWidget {
  final Store<BibleAppState> store = getIt();
  final String appTitle = 'Simple Bible';

  HomeScreen({super.key});

  @override
  build(BuildContext context) {
    return StoreProvider<BibleAppState>(
        store: store,
        child: MaterialRoot(),
    );
  }
}
