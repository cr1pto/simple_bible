import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';
import 'package:simple_bible/redux/state/bible_state.dart';
import 'package:simple_bible/screens/stateless/book_screen.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final Store<BibleAppState> store = getIt();
  final String widgetName = 'Books';

  openSelectedBook(BuildContext context, int index, BibleState state) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BookScreen(
        bookName: state.bibleVm.bibleInfo.books.firstWhere((b) => b.bookNumber == index).name,
        book: state.bibleVm.bible.books.firstWhere((b) => b.bookNumber == index),
        bible: state.bibleVm.bible,
        bibleInfo: state.bibleVm.bibleInfo
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<BibleAppState, BibleState>(
      converter: (store) => store.state.bibleState,
      builder: (ctx, state) =>  MainLayout(
        child: ListView.builder(
          itemCount: state.bibleVm.bibleInfo.books.length,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Text(state.bibleVm.bibleInfo.books[i].name.toString(),
                    style: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                    )),
                onTap: () => {
                  openSelectedBook(context, i + 1, state),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
