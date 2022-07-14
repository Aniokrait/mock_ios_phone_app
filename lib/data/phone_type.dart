import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'package:mock_ios_phone_app/pages/dial_page.dart';
import 'abst_state_notifier.dart';

@immutable
class NumberOfPhoneType extends DataType {
  NumberOfPhoneType({required this.type, required this.value});

  final String type;
  final String value;
}

// ここで<List<NumberOfPhoneType>>ではなく、<NumberOfPhoneType>を指定する
class PhoneTypeNotifier extends AbstStateNotifier<NumberOfPhoneType> {
  PhoneTypeNotifier(String inputValue) : super(NumberOfPhoneType(type: PhoneType.cell.name, value: inputValue));
}

enum PhoneType {
  cell,
  home,
  workPlace,
  school;

  @override
  String toString() {
    return name;
  }
}

extension PhoneTypeExt on PhoneType {
  String get name {
    switch (this) {
      case PhoneType.cell:
        return '携帯電話';
      case PhoneType.home:
        return '自宅';
      case PhoneType.workPlace:
        return '勤務先';
      case PhoneType.school:
        return '学校';
      default:
        return '';
    }
  }
}

final phoneTypesProvider =
    StateNotifierProvider<PhoneTypeNotifier, List<NumberOfPhoneType>>((ref) {
  return PhoneTypeNotifier(ref.watch(inputPhoneNumber));
});

