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

abstract class AbstStateNotifier<V extends DataType> extends StateNotifier<List<V>> {
  // TODO ここでsuper()にどうやってサブクラスの引数を与えるか考える
  AbstStateNotifier(Function init) : super(init());

  int length(){
    return state.length;
  }

  void add(V data) {
    state = [...state, data];
  }
}