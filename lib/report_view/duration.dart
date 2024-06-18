extension PrintFriendly on Duration {
  String printFriendly() {
    List<String> result = [];
    Duration d = this;

    int days = d.inDays;
    if (days > 0) {
      result.add("${days} days");
      d - Duration(days: days);
    }

    int hours = d.inHours;
    if (hours > 0) {
      result.add("${hours} hours");
      d - Duration(hours: hours);
    }

    int minutes = d.inMinutes;
    if (minutes > 0) {
      result.add("${minutes} minutes");
      d - Duration(minutes: minutes);
    }

    int seconds = d.inSeconds;
    if (seconds > 0) {
      result.add("${seconds} seconds");
      d - Duration(seconds: seconds);
    }

    if (result.isEmpty) {
      result.add("< second");
    }

    return result.join(", ");
  }
}
