import 'package:intl/intl.dart';

// DateTime Formatter
class DateFormatter {
  DateFormatter._();

  static String normal(String iso8601String) {
    var parsedDate = DateTime.tryParse(iso8601String);

    if (parsedDate == null) {
      return '(Invalid date format)';
    }

    return DateFormat('EEEE, d MMMM y').format(parsedDate);
  }

  static String clock(String iso8601String) {
    var parsedDate = DateTime.tryParse(iso8601String);

    if (parsedDate == null) {
      return '(Invalid date format)';
    }

    return DateFormat('HH:mm:ss').format(parsedDate);
  }
}
