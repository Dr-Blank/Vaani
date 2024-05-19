extension InverseLerp on num {
  /// Returns the fraction of this value between [min] and [max].
  double inverseLerp(num min, num max) {
    return (this - min) / (max - min);
  }
}

extension Lerp on double {
  /// Returns the value between [min] and [max] given the fraction [t].
  double lerp(double min, double max) {
    return min + ((max - min) * this);
  }
}
