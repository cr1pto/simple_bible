import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/bible.dart';
import '../../services/bible.service.dart';

part 'bible_event.dart';
part 'bible_state.dart';

class BibleBloc extends Bloc<BibleEvent, BibleState> {
  BibleBloc() : super(BibleInitial()) {
    on<LoadBible>((event, emit) async {
      final BibleService bibleService = BibleService();
      final bible = await bibleService.loadAsset();
      if (bible != null) {
        emit(BibleLoaded(bible: bible));
      } else {
        const String message = "Failed to load bible";
        emit(const BibleLoadFailed(message: message));
      }
    });
  }
}
