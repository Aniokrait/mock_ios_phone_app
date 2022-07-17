import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'package:mock_ios_phone_app/pages/dial_page.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class AddressOfEmailType extends DataType {
  AddressOfEmailType({required this.type, required this.value});

  final EmailType type;
  final String value;
}

class EmailTypeNotifier extends AbstStateNotifier<AddressOfEmailType> {
  EmailTypeNotifier()
      : super(null);

  void removeAt(int target) {
    List<AddressOfEmailType> result = [];
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
    for (AddressOfEmailType? addressOfEmailType in state) {
      if (addressOfEmailType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }
}

enum EmailType {
  home,
  workPlace,
  school;

  @override
  String toString() {
    return name;
  }
}

extension EmailTypeExt on EmailType {
  String get name {
    switch (this) {
      case EmailType.home:
        return '自宅';
      case EmailType.workPlace:
        return '勤務先';
      case EmailType.school:
        return '学校';
      default:
        return '';
    }
  }
}

final emailTypesProvider = StateNotifierProvider.autoDispose<EmailTypeNotifier,
    List<AddressOfEmailType>>((ref) {
  return EmailTypeNotifier();
});
