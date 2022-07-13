// TODO NumberOfPhoneTypeが共通の親クラスをimplするようにする
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';

// TODO AbstStateNotifierにわたすgeneicsにはListは必要ない。StateNotifierの方でList<T>と定義する
// abstract class AbstStateNotifier<T> extends StateNotifier<List<T>> {
//   // TODO ここでsuper()にどうやってサブクラスの引数を与えるか考える
//   AbstStateNotifier(Function init) : super(init());
//
//   int length(){
//     return state.length;
//   }
//
//   void add(T t) {
//     state = [...state, t];
//   }
// }

abstract class AbstStateNotifier<T extends List> extends StateNotifier<List> {
  // TODO ここでsuper()にどうやってサブクラスの引数を与えるか考える
  AbstStateNotifier(Function init) : super(init());

  int length(){
    return state.length;
  }

  void add(DataType data) {
    state = [...state, data];
  }
}