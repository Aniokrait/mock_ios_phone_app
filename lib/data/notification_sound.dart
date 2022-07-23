enum NotificationSound {
  nashi,
  memo,
  aurora,
  complete,
  circle,
  synth,
  pulse,
  hello;

  @override
  String toString() {
    return name;
  }
}

extension NotificationSoundExt on NotificationSound {
  String get name {
    switch (this) {
      case NotificationSound.nashi:
        return 'なし';
      case NotificationSound.memo:
        return 'メモ';
      case NotificationSound.aurora:
        return 'オーロラ';
      case NotificationSound.complete:
        return 'コンプリート';
      case NotificationSound.circle:
        return 'サークル';
      case NotificationSound.synth:
        return 'シンセ';
      case NotificationSound.pulse:
        return 'パルス';
      case NotificationSound.hello:
        return 'ハロー';
    }
  }
}
