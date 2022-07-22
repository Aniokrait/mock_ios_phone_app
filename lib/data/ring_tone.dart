enum RingTone {
  opening,
  uplift,
  kirameki,
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
