import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class DateOfBirthdayType extends DataType {
  DateOfBirthdayType({required this.type, required this.value});

  final BirthdayType type;
  final DateTime value;

  DateOfBirthdayType copyWith({BirthdayType? type, DateTime? value}) {
    return DateOfBirthdayType(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }
}

class BirthdayTypeNotifier extends AbstStateNotifier<DateOfBirthdayType> {
  BirthdayTypeNotifier()
      : super(null);

  void removeAt(int target) {
    List<DateOfBirthdayType> result = [];
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
    for (DateOfBirthdayType? dateOfBirthdayType in state) {
      if (dateOfBirthdayType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }

  void updateDate(int target, DateTime value) {
    List<DateOfBirthdayType> result = [];
    for(int i = 0; i < state.length; i++) {
      if (i == target) {
        result.add(state[i].copyWith(value: value));
      } else {
        result.add(state[i]);
      }
    }
    state = result;
  }
}

enum BirthdayType {
  birthday,
  birthdayInChinese,;

  @override
  String toString() {
    return name;
  }
}

extension BirthdayTypeExt on BirthdayType {
  String get name {
    switch (this) {
      case BirthdayType.birthday:
        return '誕生日';
      case BirthdayType.birthdayInChinese:
        return '誕生日（中国歴）';
      default:
        return '';
    }
  }
}

final birthdayTypesProvider = StateNotifierProvider.autoDispose<BirthdayTypeNotifier,
    List<DateOfBirthdayType>>((ref) {
  return BirthdayTypeNotifier();
});
