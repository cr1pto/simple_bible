import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/models/simple_objects/bible.dart';
import 'package:simple_bible/models/simple_objects/bible_chapter.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';
import 'package:simple_bible/models/simple_objects/bibleinfo.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/verses_screen.dart';

@Injectable()
class ChapterScreen extends StatefulWidget {
  final ItemScrollController scrollController;

  ChapterScreen({
    super.key,
    required this.scrollController
  });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleState>(
      converter: (store) => store.state.bibleState,
      builder: (ctx, state) => MainLayout(
        floatingBack: true,
        floatingBackHero: "chapter-back",
        child: VersesScreen(
          scrollController: widget.scrollController,
        ),
      ),
    );
  }
}
