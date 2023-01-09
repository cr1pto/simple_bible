import 'package:f_logs/f_logs.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class LogService {
  void info(String text) {
    FLog.info(text: text);
  }

  void fatal(String text, Object ex, StackTrace? stackTrace) {
    FLog.fatal(text: text, exception: ex, stacktrace: stackTrace);
  }

  void error(String text, Object ex, StackTrace? stackTrace) {
    FLog.error(text: text, exception: ex, stacktrace: stackTrace);
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
