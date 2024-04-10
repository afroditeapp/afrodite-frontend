

extension CheckAge on DateTime {
  // TODO(prod): Should this check the time zone as well?

  /// Is 18 years old or older
  bool isNowAdult() {
    final now = DateTime.now();
    final yearDiff = now.year - year;
    if (yearDiff > 18) return true;
    if (yearDiff < 18) return false;
    final monthDiff = now.month - month;
    if (monthDiff > 0) return true;
    if (monthDiff < 0) return false;
    final dayDiff = now.day - day;
    return dayDiff >= 0;
  }
}
