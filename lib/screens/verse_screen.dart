import 'package:flutter/material.dart';
import 'package:simple_bible/models/bible.dart';

class VerseScreen extends StatefulWidget {
  final VERS verse;
  const VerseScreen(this.verse, {Key? key}) : super(key: key);

  @override
  _VerseScreenState createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.verse.sText ?? ''),
      leading: Text(widget.verse.sVnumber ?? '',
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          )),
    );
  }
}
