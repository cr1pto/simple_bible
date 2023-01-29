import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

//the state itself that we want to define in the store
@immutable
@JsonSerializable()
class AppState{
  final location;
  final String? time;
  AppState(this.location, this.time);

  static initialState() {
    return AppState(null, "");
  }
}