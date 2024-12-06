sealed class DateTimeAdapter {
  static String dateTimeToOFXString(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');
    String millisecond = dateTime.millisecond.toString().padLeft(3, '0');
    String timeZone = dateTime.timeZoneOffset.inHours.toString().padLeft(4, '0');
    String sign = dateTime.timeZoneOffset.isNegative ? '-' : '+';


    return '$year$month$day$hour$minute$second.$millisecond[$sign$timeZone]';
  }

  static DateTime stringToDateTime(String dateString) {
    // match YYYYMMDDHHMMSS.XXX [gmt offset[:tz name]]
    // optional time, fractional seconds, and timezone
    RegExp regex = RegExp(r'^(\d{8})(\d{6})?(\.\d{1,3})?(?:\s?\[(\+|-)?(\d{4})(?::[^\]]+)?\])?$');
    var match = regex.firstMatch(dateString);

    if (match == null) {
      throw Exception('Invalid OFX date format: $dateString');
    }
    final datePart = match.group(1)!; // YYYYMMDD
    final timePart = match.group(2) ?? "000000"; // HHMMSS
    final fractionalPart = match.group(3) ?? ""; // .XXX (default to no fractional seconds)
    final gmtSign = match.group(4) ?? "+"; // Default to '+' if no sign is present
    final gmtOffset = match.group(5) ?? "0000"; // Default to UTC if no offset is present

    return DateTime.parse("${datePart}T$timePart$fractionalPart $gmtSign$gmtOffset");
  }

  static DateTime stringToDateTimeLocal(String dateString) {
    return stringToDateTime(dateString).toLocal();
  }
}
