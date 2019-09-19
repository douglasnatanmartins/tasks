import 'package:intl/intl.dart';

class DateTimeUtil {
  static String get currentDate {
    return DateFormat('d').format(DateTime.now());
  }

  static String get currentDay {
    return DateFormat('EEEE').format(DateTime.now());
  }

  static String get currentMonth {
    return DateFormat('MMM').format(DateTime.now());
  }
}
