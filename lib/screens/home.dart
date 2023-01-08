import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/layouts/main_layout.dart';
import 'package:simple_bible/screens/home_options_screen.dart';

@Injectable()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: HomeOptionsScreen(),
    );
  }
}
