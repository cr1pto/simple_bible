import 'package:flutter/material.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/services/log.service.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final searchTextController = TextEditingController();
  final LogService logService = getIt();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    searchTextController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchTextController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    logService.info('Second text field: ${searchTextController.text}');
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
    );
  }
}
