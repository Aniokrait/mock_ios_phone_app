import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_container.dart';

@immutable
class NumberOfPhoneType {
  const NumberOfPhoneType({required this.type, required this.number});

  final String type;
  final String number;
}

class PhoneTypeNotifier extends StateNotifier<List<NumberOfPhoneType>> {
  PhoneTypeNotifier() : super(init());

  void addPhoneType(NumberOfPhoneType phoneType) {
    state.insert(state.length - 2, phoneType);
  }
}

List<NumberOfPhoneType> init() {
  return [NumberOfPhoneType(type: PhoneType.cell.name, number: '1')];
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
  return PhoneTypeNotifier();
});
