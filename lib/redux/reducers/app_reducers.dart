import 'package:simple_bible/redux/actions/fetch_time.dart';
import 'package:simple_bible/redux/state/app_state.dart';

// AppState reducer(AppState previousState, action){
//   if(action == Actions.Add){
//     return AppState(previousState.value +  1);
//   }
//   if(action == Actions.Subtract){
//     return AppState(previousState.value -  1);
//   }
//   return previousState;
// }

//the reducer to reduce the state; i.e., return the state that we care about.   The dynamic property is an action.
AppState reducer(AppState prev, dynamic action) {
  if (action is FetchTimeAction) {
    return AppState(action.location, action.time);
  } else {
    return prev;
  }
}