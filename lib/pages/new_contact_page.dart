import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/widgets/add_line_row.dart';
import 'package:mock_ios_phone_app/pages/widgets/custom_appbar.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_container.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_text_form_field.dart';
import 'package:mock_ios_phone_app/pages/widgets/design_rules.dart';
import 'package:collection/collection.dart';

import '../data/phone_type.dart';

class NewContactPage extends ConsumerWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(
        leadingText: 'キャンセル',
        mainTitle: '新規連絡先',
        trailingText: 'OK',
      ),
      body: _ContactForm(),
    );
  }
}

class _ContactForm extends ConsumerWidget {
  const _ContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('写真を追加'),
          ),
          Form(
            child: Column(
              children: const [
                //基本情報ブロック
                _BasicInfosField(),
                SizedBox(
                  height: itemHeight,
                ),
                //優先する回線
                _CarrierField(),
                SizedBox(
                  height: itemHeight,
                ),
                _PhoneNumbersField(),
                // メール

                // 着信音

                // メッセージ

                // URL

                // 住所

                // 誕生日

                // 日付

                // 関係

                // SNS

                // インスタントメッセージ

                // メモ

                // フィールドを追加
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 姓名等基本情報のフィールド
class _BasicInfosField extends StatelessWidget {
  const _BasicInfosField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Column(
        children: const [
          DecoratedTextFormField('姓'),
          DecoratedTextFormField('姓（フリガナ）'),
          DecoratedTextFormField('名'),
          DecoratedTextFormField('名（フリガナ）'),
          DecoratedTextFormField('会社名'),
          DecoratedTextFormField(
            '会社名（フリガナ）',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

/// 優先する回線のフィールド
class _CarrierField extends StatelessWidget {
  const _CarrierField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: SizedBox(
        height: itemHeight,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('優先する回線'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text('デフォルトー”楽天モバイル”'),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneNumbersField extends ConsumerWidget {
  const _PhoneNumbersField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /////////////////////////////////////////
    List<Widget> inputFields = ref
        .watch(phoneTypesProvider)
        .mapIndexed((index, element) => Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: lineColor),
                ),
              ),
              child: SizedBox(
                height: itemHeight,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: kMinInteractiveDimension,
                      ),
                      padding: const EdgeInsets.only(left: 0),
                      onPressed: () {
                        ref.read(phoneTypesProvider.notifier).removeAt(index);
                      },
                    ),
                    Text(element.type),
                    const Icon(Icons.chevron_right),
                    Text(element.value),
                  ],
                ),
              ),
            ))
        .toList();
    /////////////////////////////////////////

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          // //stateの数だけforで回す
          // for (var phoneType in ref.watch(phoneTypesProvider)) ...{
          //   Container(
          //     decoration: const BoxDecoration(
          //       border: Border(
          //         bottom: BorderSide(color: lineColor),
          //       ),
          //     ),
          //     child: SizedBox(
          //       height: itemHeight,
          //       child: Row(
          //         children: [
          //           IconButton(
          //             icon: const Icon(
          //               Icons.remove_circle,
          //               color: Colors.red,
          //             ),
          //             constraints: const BoxConstraints(
          //               minWidth: 0,
          //               minHeight: kMinInteractiveDimension,
          //             ),
          //             padding: const EdgeInsets.only(left: 0),
          //             onPressed: () {},
          //           ),
          //           Text(phoneType.type),
          //           const Icon(Icons.chevron_right),
          //           Text(phoneType.value!),
          //         ],
          //       ),
          //     ),
          //   ),
          // },
          //電話を追加行
          AddLineRow(
              title: '電話を追加',
              provider: phoneTypesProvider,
              labelValues: PhoneType.values),
        ],
      ),
    );
  }
}
