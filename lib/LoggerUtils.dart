import 'package:logger/logger.dart';
class LoggerUtils {
  static final Logger _logger = Logger();

  static void logInfo(String message) {
    _logger.i(message); // Log an info message
  }

  static void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}