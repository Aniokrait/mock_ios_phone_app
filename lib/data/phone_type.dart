import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'package:mock_ios_phone_app/pages/dial_page.dart';
import 'abst_state_notifier.dart';

//@immutable
class NumberOfPhoneType extends DataType {
  NumberOfPhoneType({required this.type});

  final String type;
  late String? value = '';
}

// ここで<List<NumberOfPhoneType>>ではなく、<NumberOfPhoneType>を指定する
class PhoneTypeNotifier extends AbstStateNotifier<NumberOfPhoneType> {
  PhoneTypeNotifier() : super(init);

  //StateNotifierProviderインスタンス生成時に呼ばれる。
  void changeFirstValue(String value) {
    state[0].value = value;
  }
}

List<NumberOfPhoneType> init() {
  // StateNotifierインスタンス生成時はvalueにnullを代入し、StateNotifierProvider
  // インスタンス生成時にダイアルパッドの番号を代入する。
  return [NumberOfPhoneType(type: PhoneType.cell.name)];
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
  var phoneTypeNotifier = PhoneTypeNotifier();
  phoneTypeNotifier.changeFirstValue(ref.watch(inputPhoneNumber));
  return phoneTypeNotifier;
});

