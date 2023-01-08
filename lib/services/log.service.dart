import 'package:f_logs/f_logs.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class LogService {
  void info(String text) {
    FLog.info(text: text);
  }

  void fatal(String text, Object ex) {
    FLog.fatal(text: text, exception: ex);
  }

  void error(String text, Object ex) {
    FLog.error(text: text, exception: ex);
  }

  void warning(String text) {
    FLog.warning(text: text);
  }

  void debug(String text) {
    FLog.debug(text: text);
  }

  static LogService getInstance() {
    return LogService();
  }
}
