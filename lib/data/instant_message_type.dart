import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'abst_state_notifier.dart';
import 'package:collection/collection.dart';

@immutable
class MessageOfInstantMsgType extends DataType {
  MessageOfInstantMsgType({required this.type, required this.value});

  final InstantMessageType type;
  final String value;
}

class InstantMessageTypeNotifier extends AbstStateNotifier<MessageOfInstantMsgType> {
  InstantMessageTypeNotifier()
      : super(null);

  void removeAt(int target) {
    List<MessageOfInstantMsgType> result = [];
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
    for (MessageOfInstantMsgType? messageOfInstantMsgType in state) {
      if (messageOfInstantMsgType?.type == e) {
        isContain = true;
        break;
      }
    }
    return isContain;
  }
}

enum InstantMessageType {
  skype,
  msnMessenger,
  googleTalk;

  @override
  String toString() {
    return name;
  }
}

extension InstantMessageTypeExt on InstantMessageType {
  String get name {
    switch (this) {
      case InstantMessageType.skype:
        return 'Skype';
      case InstantMessageType.msnMessenger:
        return 'MSNメッセンジャー';
      case InstantMessageType.googleTalk:
        return 'Googleトーク';
      default:
        return '';
    }
  }
}

final instantMessageTypesProvider = StateNotifierProvider.autoDispose<InstantMessageTypeNotifier,
    List<MessageOfInstantMsgType>>((ref) {
  return InstantMessageTypeNotifier();
});
