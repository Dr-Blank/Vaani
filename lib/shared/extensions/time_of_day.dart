import 'package:flutter/material.dart';

extension ToTimeOfDay on Duration {
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(
      hour: inHours % 24,
      minute: inMinutes % 60,
    );
  }
}

extension ToDuration on TimeOfDay {
  Duration toDuration() {
    return Duration(hours: hour, minutes: minute);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }

  bool operator <(TimeOfDay other) => compareTo(other) < 0;
  bool operator >(TimeOfDay other) => compareTo(other) > 0;
  bool operator <=(TimeOfDay other) => compareTo(other) <= 0;
  bool operator >=(TimeOfDay other) => compareTo(other) >= 0;

  bool isBefore(TimeOfDay other) => this < other;
  bool isAfter(TimeOfDay other) => this > other;
}
