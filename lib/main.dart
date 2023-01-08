import 'package:flutter/material.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/screens/myapp.dart';
import 'package:simple_bible/services/log.service.dart';

void main() async {
  LogService logService = LogService();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      logService.fatal(details.exception.toString(), details.exception);
    };
    await configureDependencies();
    runApp(MyApp());
  } catch (exception) {
    logService.fatal("The application crashed.", exception);
  }
}