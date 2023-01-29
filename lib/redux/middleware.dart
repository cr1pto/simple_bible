import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:simple_bible/redux/state/bible_app_state.dart';

final Persistor<BibleAppState> persistor = Persistor<BibleAppState>(
    storage: FlutterStorage(), serializer: JsonSerializer<BibleAppState>((json) => BibleAppState.fromJson(json)));

// Set up middleware
List<Middleware<BibleAppState>> createMiddleware() => <Middleware<BibleAppState>>[
  thunkMiddleware,
  persistor.createMiddleware(),
  LoggingMiddleware.printer(),
];