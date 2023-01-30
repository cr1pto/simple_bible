import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_bible/injection.config.dart';
import 'package:simple_bible/services/log.service.dart';

GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  try{
    await getIt.init();
  }
  catch(ex, stackTrace){
    LogService logService = LogService();
    logService.fatal(ex.toString(), ex, stackTrace );
    rethrow;
  }
}