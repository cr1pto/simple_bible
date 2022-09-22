import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/screens/book_screen.dart';
import 'package:simple_bible/shared/menu_bar.dart';

class BooksScreen extends StatefulWidget {
  final String widgetName = 'Books';
  final List<BIBLEBOOK> books;
  final int settingColor;
  final double fontSize;
  const BooksScreen(this.settingColor, this.fontSize, this.books, {Key? key})
      : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late Widget bookWidget;
  @override
  void initState() {
    setState(() {
      bookWidget = getWidgets();
    });
    super.initState();
  }

  Widget getWidgets() {
    List<Widget> allBooks = [];

    for (BIBLEBOOK book in widget.books) {
      allBooks.add(ListTile(
          title: Text(book.sBname ?? ''),
          onTap: () {
            // pop the stack so that the drawer doesn't open up again since it gets pushed onto the navigation route stack
            // Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BookScreen(book)));
          }));
    }

    return Scaffold(
      body: ListView(children: allBooks),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_circle_left),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.widgetName),
      //   // backgroundColor: Color(settingColor),
      // ),
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      body: getWidgets(),
    );
  }
}
