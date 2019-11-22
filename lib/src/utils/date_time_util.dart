class DateTimeUtil {
  static Duration difference(DateTime date) {
    return date.difference(DateTime.now());
  }

  static DateTime onlyDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
