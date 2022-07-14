import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';

// AbstStateNotifierのgeneicsにはListは必要ない。StateNotifierの方でList<T>と定義する
abstract class AbstStateNotifier<V extends DataType> extends StateNotifier<List<V>> {
  // サブクラスで定義した関数をスーパークラスに渡す
  AbstStateNotifier(Function init) : super(init());

  int length(){
    return state.length;
  }

  void add(V data) {
    state = [...state, data];
  }
}