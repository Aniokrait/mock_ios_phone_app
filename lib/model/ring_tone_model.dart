import 'package:mock_ios_phone_app/data/notification_sound.dart';
import 'package:mock_ios_phone_app/data/ring_tone.dart';

class RingToneModel {
  RingToneModel(
      {this.targetSound1,
      this.targetSound2,
      required this.isCallWhenAlert,
      this.isDefaultSound = false})
      : assert(targetSound1 != null || targetSound2 != null);
  final RingTone? targetSound1;
  final NotificationSound? targetSound2;
  final bool isCallWhenAlert;
  bool isDefaultSound;
}
