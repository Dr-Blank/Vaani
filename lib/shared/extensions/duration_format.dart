extension DurationFormat on Duration {
  /// formats the duration using only 2 units
  ///
  /// if the duration is more than 1 hour, it will return `10h 30m`
  /// if the duration is less than 1 hour, it will return `30m 20s`
  /// if the duration is less than 1 minute, it will return `20s`
  String get smartBinaryFormat {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    if (hours > 0) {
      // skip minutes if it's 0
      if (minutes == 0) {
        return smartSingleFormat;
      }
      return '${Duration(hours: hours).smartBinaryFormat} ${Duration(minutes: minutes).smartSingleFormat}';
    } else if (minutes > 0) {
      if (seconds == 0) {
        return smartSingleFormat;
      }
      return '${Duration(minutes: minutes).smartSingleFormat} ${Duration(seconds: seconds).smartSingleFormat}';
    } else {
      return smartSingleFormat;
    }
  }

  /// formats the duration using only 1 unit
  /// if the duration is more than 1 hour, it will return `10h`
  /// if the duration is less than 1 hour, it will return `30m`
  /// if the duration is less than 1 minute, it will return `20s`
  ///
  /// rest of the duration will be ignored
  String get smartSingleFormat {
    if (inHours > 0) {
      return '${inHours}h';
    } else if (inMinutes > 0) {
      return '${inMinutes}m';
    } else {
      return '${inSeconds}s';
    }
  }
}

extension OnlyTime on DateTime {
  // in format HH:MM:ss
  // padding with 0
  String get time =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
}
