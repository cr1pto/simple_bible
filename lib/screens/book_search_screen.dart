// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class BookSearchScreen extends StatefulWidget {
  // final List<BIBLEBOOK> books;
  final int settingColor;
  final double fontSize;
  final BibleService bibleService;

  const BookSearchScreen(this.settingColor, this.fontSize, {Key? key, required this.bibleService})
      : super(key: key);

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  static List<String> availableBooks = [];
  Widget bookWidget = const ListTile();
  // BIBLEBOOK? selectedBook;
  final TextEditingController txtSearch = TextEditingController();

  Widget getBook() {
    Widget bkWidget = bookWidget;

    return bkWidget;
  }

  @override
  void initState() {
    // settings.init().then((value) async {
    //   bible = await widget.bibleService.loadAsset();
    //   setState(() {
    //     settingColor = settings.getColor();
    //     fontSize = settings.getFontSize();
    //     books = widget.bibleService.getBooksFromBible(bible);
    //   });
    // });
    // availableBooks = widget.books.map((book) => book.sBname ?? '').toList();

    // if(widget.books.isNotEmpty) {
    //   setState(() {
    //     bookWidget = widget.bibleService
    //         .getBookScreenByName(availableBooks.first.toString(), widget.books);
    //   });
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search the Bible for...'),
          // backgroundColor: Color(settingColor),
        ),
        body: ListView(
          children: [
            TextField(
                controller: txtSearch,
                decoration: InputDecoration(
                    hintText: 'Search the Bible...',
                    prefixIcon: IconButton(
                        onPressed: () {
                          // setState(() {
                          //   bookWidget = widget.bibleService
                          //       .getBookScreenByName(
                          //           selectedBook?.sBname ?? '', widget.books);
                          // });
                        },
                        icon: const Icon(Icons.book_online)))),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return availableBooks.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String book) {
                setState(() {
                  // selectedBook = widget.bibleService.getBookByName(book, widget.books);
                  // bookWidget = widget.bibleService
                  //     .getBookScreenByName(book, widget.books);
                });
              },
            ),
            getBook()
          ],
        ));
  }
}
