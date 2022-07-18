import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class ProfileOfSnsType extends DataType {
  ProfileOfSnsType({required this.type, required this.value});

  final SnsType type;
  final String value;
}

class SnsTypeNotifier extends AbstStateNotifier<ProfileOfSnsType> {
  SnsTypeNotifier()
      : super(null);

  void removeAt(int target) {
    List<ProfileOfSnsType> result = [];
    state.forEachIndexed((index, element) {
      result = [
        ...result,
        if (index != target) element,
      ];
    });
    state = result;
  }

  @override
  bool contains<E extends Enum>(E e) {
    bool isContain = false;
    for (ProfileOfSnsType? profileOfSnsType in state) {
      if (profileOfSnsType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }
}

enum SnsType {
  twitter,
  facebook,
  flicker;

  @override
  String toString() {
    return name;
  }
}

extension SnsTypeExt on SnsType {
  String get name {
    switch (this) {
      case SnsType.twitter:
        return 'Twitter';
      case SnsType.facebook:
        return 'Facebook';
      case SnsType.flicker:
        return 'Flicker';
      default:
        return '';
    }
  }
}

final snsTypesProvider = StateNotifierProvider.autoDispose<SnsTypeNotifier,
    List<ProfileOfSnsType>>((ref) {
  return SnsTypeNotifier();
});
