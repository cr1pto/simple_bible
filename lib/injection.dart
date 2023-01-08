import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.config.dart';

GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();