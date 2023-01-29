import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/shared_prefs.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/screens/stateless/books_screen.dart';

@Injectable()
class BibleScreen extends StatelessWidget {
  final SPSettings settings = getIt();

  BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Bible',
      floatingBack: true,
      floatingBackHero: 'home-back',
      child: BlocBuilder<BibleBloc, BibleState>(
        builder: (context, state) {
          if (state is BibleLoaded) {
            return BooksScreen(bibleInfo: state.info, bible: state.bible);
          }
          return Container();
        },
      ),
    );
  }
}
