import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/widgets/border.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_container.dart';

import '../data/phone_type.dart';

const lineColor = Colors.black12;
const double itemHeight = 44;

class NewContactPage extends ConsumerWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'キャンセル',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        title: const Text('新規連絡先'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ContactForm(ref),
    );
  }

  SingleChildScrollView ContactForm(WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('写真を追加'),
          ),
          Form(
            child: Column(
              children: [
                //基本情報ブロック
                DecoratedContainer(
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
                ),
                //回線
                const SizedBox(
                  height: itemHeight,
                ),
                DecoratedContainer(
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
                ),
                const SizedBox(
                  height: itemHeight,
                ),
                // 電話番号
                DecoratedContainer(
                  child: Column(
                    children: [
                      //stateの数だけforで回す
                      for (var phoneType in ref.watch(phoneTypesProvider)) ...{
                        SizedBox(
                          height: itemHeight,
                          child: Row(
                            children: [
                              const Icon(Icons.remove_circle, color: Colors.red,),
                              Text(phoneType.type),
                              const Icon(Icons.chevron_right),
                              Text(phoneType.number),
                            ],
                          ),
                        ),
                      },
                      //forの外で電話を追加の行を生成する。

                      SizedBox(
                        height: itemHeight,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add_circle,
                              color: Colors.lightGreen,
                            ),
                            Text('電話を追加'),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
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

class DecoratedTextFormField extends StatelessWidget {
  const DecoratedTextFormField(this.title, {Key? key, this.isLast = false})
      : super(key: key);

  final String title;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: title,
          // 最後の要素はTextFieldの下線とContainerの下線が被るので消す。
          enabledBorder: isLast ? InputBorder.none : underBorder,
          focusedBorder: isLast ? InputBorder.none : underBorder,
        ),
      ),
    );
  }
}
