import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bible/models/bible.dart';
import 'package:simple_bible/services/bible.service.dart';

part 'bible_event.dart';
part 'bible_state.dart';

class BibleBloc extends Bloc<BibleEvent, BibleState> {
  BibleBloc() : super(BibleInitial()) {
    on<LoadBible>((event, emit) async {
      final bibleService = BibleService();
      try {
        final info = await bibleService.loadInfo();
        final bible = await bibleService.loadKJV();
        emit(BibleLoaded(info: info, bible: bible));
      } catch (e) {
        debugPrint('Error loading bible: $e');
        const String message = "Failed to load bible";
        emit(const BibleLoadFailed(message: message));
      }
    });
  }
}
