import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/abst_state_notifier.dart';
import '../../data/phone_type.dart';
import 'design_rules.dart';

class AddLineRow<E extends Enum> extends ConsumerWidget {
  const AddLineRow({Key? key, required this.title, required this.provider, required this.labelValues}) : super(key: key);

  final String title;
  final StateNotifierProvider<AbstStateNotifier, List> provider;
  final List<E> labelValues;

  void addLine<T>(Reader read) {
    var currentRows = read(provider.notifier);

    // 各種タイプより多い数が追加された場合は規定のフィールドを追加する
    String targetType = PhoneType.cell.name;
    if (currentRows.length() < labelValues.length) {
      targetType = labelValues[currentRows.length()].name;
    }
    // TODO ナンバーを前画面から持ってきて設定する
    currentRows.add(NumberOfPhoneType(type: targetType));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => addLine(ref.read),
      child: SizedBox(
        height: itemHeight,
        child: Row(
          children: [
            const Icon(
              Icons.add_circle,
              color: Colors.lightGreen,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

