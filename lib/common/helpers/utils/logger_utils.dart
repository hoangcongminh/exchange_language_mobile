import 'package:logger/logger.dart';

class LoggerUtils {
  static final LoggerUtils _instance = LoggerUtils._internal();

  factory LoggerUtils() {
    return _instance;
  }

  LoggerUtils._internal();

  static log({String? mode, String? message}) {
    final logger = Logger(
        printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 1,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: false,
    ));
    switch (mode) {
      case 'v':
        logger.v(message);
        break;
      case 'd':
        logger.d(message);
        break;
      case 'i':
        logger.i(message);
        break;
      case 'w':
        logger.w(message);
        break;
      case 'e':
        logger.e(message);
        break;
      default:
        logger.i(message);
        break;
    }
  }
}
