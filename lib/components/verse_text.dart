import 'package:flutter/material.dart';

class VerseText extends StatelessWidget {
  final double fontSize;
  final String verseText;
  final int verseNumber;
  final bool selected;
    final Function(Key? key)? onTap;

  const VerseText({super.key, required this.fontSize, required this.verseText, required this.verseNumber, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(verseText,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
              fontSize: fontSize,
            )),
        onTap: () => onTap!(super.key),
        selected: selected,
        // selectedTileColor: const Color(0x000003e7),
        focusColor: const Color(0x000003e7),
        // focusColor: const Color(0x0000000a),
        leading: Text(
          verseNumber.toString(),
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
