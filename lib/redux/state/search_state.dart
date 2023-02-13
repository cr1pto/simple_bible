import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simple_bible/models/simple_objects/bible_verse.dart';

part 'search_state.g.dart';

//the state itself that we want to define in the store
@immutable
@JsonSerializable()
class SearchState{
  String searchText = "";
  List<BibleVerse> verses = List.empty();

  SearchState({required this.searchText, required this.verses});
  SearchState.initial();

  factory SearchState.fromJson(Map<String, dynamic> json) => _$SearchStateFromJson(json);
  Map<String, dynamic> toJson() => _$SearchStateToJson(this);
}