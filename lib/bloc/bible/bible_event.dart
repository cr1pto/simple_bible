part of 'bible_bloc.dart';

abstract class BibleEvent extends Equatable {
  const BibleEvent();

  @override
  List<Object> get props => [];
}

class LoadBible extends BibleEvent {
  const LoadBible();

  @override
  List<Object> get props => [];
}
