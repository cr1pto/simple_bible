import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:simple_bible/redux/state/app_state.dart';

//Action that dispatches to the store
ThunkAction<AppState> fetchTime = (Store<AppState> store) async {

  List<dynamic> locations;

  try {
    Response response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/'));
    locations = jsonDecode(response.body);
  }catch(e){
    print('caught error: $e');
    return;
  }

  String time;
  String location = locations[Random().nextInt(locations.length)] as String;
  try {
    Response response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/$location'));
    Map data = jsonDecode(response.body);

    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    DateTime date = DateTime.parse(dateTime);
    date = date.add(Duration(hours: int.parse(offset)));
    time = DateFormat.jm().format(date);
  }catch(e){
    print('caught error: $e');
    time = "could not fetch time data";
    return;
  }

  List<String> val = location.split("/");
  location = "${val[1]}, ${val[0]}";

  store.dispatch(FetchTimeAction(location, time));
};

//the action definition containing the properties to dispatch
class FetchTimeAction {
  final String _location;
  final String _time;

  String get location => _location;
  String get time => _time;

  FetchTimeAction(this._location, this._time);
}