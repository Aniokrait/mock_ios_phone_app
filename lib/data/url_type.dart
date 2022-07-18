import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class UrlOfUrlType extends DataType {
  UrlOfUrlType({required this.type, required this.value});

  final UrlType type;
  final String value;
}

class UrlTypeNotifier extends AbstStateNotifier<UrlOfUrlType> {
  UrlTypeNotifier()
      : super(null);

  void removeAt(int target) {
    List<UrlOfUrlType> result = [];
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
    for (UrlOfUrlType? urlOfUrlType in state) {
      if (urlOfUrlType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }
}

enum UrlType {
  homePage,
  home,
  workPlace,
  school;

  @override
  String toString() {
    return name;
  }
}

extension UrlTypeExt on UrlType {
  String get name {
    switch (this) {
      case UrlType.homePage:
        return 'ホームページ';
      case UrlType.home:
        return '自宅';
      case UrlType.workPlace:
        return '勤務先';
      case UrlType.school:
        return '学校';
      default:
        return '';
    }
  }
}

final urlTypesProvider = StateNotifierProvider.autoDispose<UrlTypeNotifier,
    List<UrlOfUrlType>>((ref) {
  return UrlTypeNotifier();
});
