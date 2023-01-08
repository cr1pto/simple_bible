// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.dart';
import 'package:simple_bible/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bible/bloc/bible/bible_bloc.dart';
import 'package:simple_bible/services/bible.service.dart';

@Injectable()
class MyApp extends StatelessWidget {
  final BibleService bibleService = getIt();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BibleBloc(bibleService)..add(const LoadBible()),
        )
      ],
      child: MaterialApp(
        title: 'Simple Bible',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
