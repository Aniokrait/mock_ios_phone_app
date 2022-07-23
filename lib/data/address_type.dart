import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class DetailsOfAddressType extends DataType {
  DetailsOfAddressType({
    required this.type,
    this.postalNumber,
    this.prefecture,
    this.city,
    this.address1,
    this.address2,
    this.country,
  });

  final AddressType type;
  final String? postalNumber;
  final String? prefecture;
  final String? city;
  final String? address1;
  final String? address2;
  final String? country;
}

class AddressTypeNotifier extends AbstStateNotifier<DetailsOfAddressType> {
  AddressTypeNotifier() : super(null);

  void removeAt(int target) {
    List<DetailsOfAddressType> result = [];
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
    for (DetailsOfAddressType? detailsOfAddressType in state) {
      if (detailsOfAddressType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }
}

enum AddressType {
  home,
  workplace,
  school,
  other;

  @override
  String toString() {
    return name;
  }
}

extension AddressTypeExt on AddressType {
  String get name {
    switch (this) {
      case AddressType.home:
        return '自宅';
      case AddressType.workplace:
        return '勤務先';
      case AddressType.school:
        return '学校';
      case AddressType.other:
        return 'その他';
    }
  }
}

final addressTypesProvider = StateNotifierProvider.autoDispose<
    AddressTypeNotifier, List<DetailsOfAddressType>>((ref) {
  return AddressTypeNotifier();
});
