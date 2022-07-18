import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class DateOfDateType extends DataType {
  DateOfDateType({required this.type, required this.value});

  final DateType type;
  final DateTime value;

  DateOfDateType copyWith({DateType? type, DateTime? value}) {
    return DateOfDateType(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }
}

class DateTypeNotifier extends AbstStateNotifier<DateOfDateType> {
  DateTypeNotifier()
      : super(null);

  void removeAt(int target) {
    List<DateOfDateType> result = [];
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
    for (DateOfDateType? dateOfDateType in state) {
      if (dateOfDateType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }

  void updateDate(int target, DateTime value) {
    List<DateOfDateType> result = [];
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

enum DateType {
  anniversary,
  others;

  @override
  String toString() {
    return name;
  }
}

extension DateTypeExt on DateType {
  String get name {
    switch (this) {
      case DateType.anniversary:
        return '記念日';
      case DateType.others:
        return 'その他';
      default:
        return '';
    }
  }
}

final dateTypesProvider = StateNotifierProvider.autoDispose<DateTypeNotifier,
    List<DateOfDateType>>((ref) {
  return DateTypeNotifier();
});
