extension DurationFormat on Duration {
  /// formats the duration of the book as `10h 30m`
  ///
  /// will add up all the durations of the audio files first
  /// then convert them to the given format
  String get formattedBinary {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}
