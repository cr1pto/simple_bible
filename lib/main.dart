import 'package:flutter/material.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/screens/myapp.dart';
import 'package:simple_bible/services/log.service.dart';

void main() async {
  LogService logService = LogService();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      logService.fatal(details.exception.toString(), details.exception, details.stack );
    };
    await configureDependencies();
    runApp(MyApp());
  } catch (exception, stacktrace) {
    logService.fatal("The application crashed.", exception, stacktrace);
  }
}