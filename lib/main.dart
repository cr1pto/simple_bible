import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/screens/home.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    //this line prints the default flutter gesture caught exception in console
    //FlutterError.dumpErrorToConsole(details);
    FLog.fatal(text: details.exception.toString(), exception: details.exception);
  };
  try{
    runApp(const MyApp());
  }
  catch(exception) {
    FLog.fatal(text: "The application crashed.", exception: exception);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BibleBloc()..add(const LoadBible()),
        )
      ],
      child: MaterialApp(
        title: 'Simple Bible',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
