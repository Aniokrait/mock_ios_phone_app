import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class RelationOfRelationType extends DataType {
  RelationOfRelationType({required this.type, required this.value});

  final RelationType type;
  final String value;
}

class RelationTypeNotifier extends AbstStateNotifier<RelationOfRelationType> {
  RelationTypeNotifier() : super(null);

  void removeAt(int target) {
    List<RelationOfRelationType> result = [];
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
    for (RelationOfRelationType? relationOfRelationType in state) {
      if (relationOfRelationType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }
}

enum RelationType {
  parent,
  brother,
  sister;

  @override
  String toString() {
    return name;
  }
}

extension RelationTypeExt on RelationType {
  String get name {
    switch (this) {
      case RelationType.parent:
        return '親';
      case RelationType.brother:
        return '兄弟';
      case RelationType.sister:
        return '姉妹';
      default:
        return '';
    }
  }
}

final relationTypesProvider = StateNotifierProvider.autoDispose<
    RelationTypeNotifier, List<RelationOfRelationType>>((ref) {
  return RelationTypeNotifier();
});
