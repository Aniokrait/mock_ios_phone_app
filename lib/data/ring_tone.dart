enum RingTone {
  opening,
  uplift,
  kirameki;

  @override
  String toString() {
    return name;
  }
}

extension RingToneExt on RingTone {
  String get name {
    switch (this) {
      case RingTone.opening:
        return 'オープニング';
      case RingTone.uplift:
        return 'アップリフト';
      case RingTone.kirameki:
        return 'きらめき';
      default:
        throw UnimplementedError();
    }
  }
}
