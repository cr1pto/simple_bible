import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/services/bible.service.dart';

class RecentVerse extends StatefulWidget {
  RecentVerse({
    super.key,
    required this.verse,
  });

  final BibleVerse verse;

  @override
  State<RecentVerse> createState() => _RecentVerseState();

  final BibleService bibleService = BibleService();
}

class _RecentVerseState extends State<RecentVerse> {
  SembastDb sembastDb = SembastDb();

  @override
  void initState() {
    // settings.init().then((value) async {
    //   setState(() {
    //     settingColor = settings.getColor();
    //     fontSize = settings.getFontSize();
    //     color = Color(settingColor);
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BibleBloc, BibleState>(
      builder: (context, state) {
        if (state is BibleLoaded) {
          // return BooksScreen(books: state.info.books, bible: state.bible);
          BibleInfoBook bookInfo = widget.bibleService.getBookInfoFromBookNumberIndex(state.bible, state.info, widget.verse.bookNumber - 1);
          return Card(
            child: ListTile(
              title: Text(
                  "${bookInfo.name} ${widget.verse.chapterNumber}:${widget.verse.index} - ${widget.verse.text}",
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                )),
            ),
          );
        }
        return Container();
      },
    );
  }
}
