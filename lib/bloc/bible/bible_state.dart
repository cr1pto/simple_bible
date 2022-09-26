part of 'bible_bloc.dart';

abstract class BibleState extends Equatable {
  const BibleState();

  @override
  List<Object> get props => [];
}

class BibleInitial extends BibleState {}

class BibleLoaded extends BibleState {
  final BibleInfo info;
  final Bible bible;

  const BibleLoaded({required this.info, required this.bible});

  @override
  List<Object> get props => [info, bible];
}

class BibleLoadFailed extends BibleState {
  final String message;

  const BibleLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}
