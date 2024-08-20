extension TimeExtention on DateTime{
  String get toFormattedDate{
    return "$day / $month / $year";
  }

  String get dayName{
    List<String> days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun",];
    return days[weekday - 1];
  }
}