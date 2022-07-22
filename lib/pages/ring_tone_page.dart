import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/widgets/custom_appbar.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_container.dart';
import 'package:mock_ios_phone_app/pages/widgets/design_rules.dart';

class RingTonePage extends ConsumerWidget {
  const RingTonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(
        leadingText: 'キャンセル',
        mainTitle: '着信音',
        trailingText: '完了',
      ),
      body: _RingToneForm(),
    );
  }
}

class _RingToneForm extends ConsumerWidget {
  const _RingToneForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DecoratedContainer(
            ///緊急時は鳴らす
            child: Row(
              children: [
                const Text('緊急時は鳴らす'),
                const Spacer(),
                Switch.adaptive(
                  value: ref.watch(isCallWhenAlert),
                  onChanged: (bool newValue) {
                    ref.read(isCallWhenAlert.notifier).state = newValue;
                  },
                ),
              ],
            ),
          ),
          const Text(
            '"緊急時は鳴らす"は、着信スイッチが消音に設定されている場合、'
            'または集中モードがオンになっている場合でも、この人からの着信音や'
            'バイブレーションを許可します。',
            style: TextStyle(
              fontSize: 13,
            ),
          ),

          ///バイブレーション
          DecoratedContainer(
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: itemHeight,
                child: Row(
                  children: const [
                    Text('バイブレーション'),
                    Spacer(),
                    Text('デフォルト'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),

          ///デフォルト
          Container(
            margin: const EdgeInsets.only(top: 18),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'デフォルト',
              style: TextStyle(fontSize: 12),
            ),
          ),
          DecoratedContainer(
            child: SizedBox(
              height: itemHeight,
              child: Row(
                children: const [
                  Icon(
                    Icons.check,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text('オープニング'),
                ],
              ),
            ),
          ),

          ///着信音
          Container(
            margin: const EdgeInsets.only(top: 18),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              '着信音',
              style: TextStyle(fontSize: 12),
            ),
          ),
          DecoratedContainer(
            child: Column(
              children: [
                SizedBox(
                  height: itemHeight,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: lineColor),
                        ),
                        //color: Colors.blue
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints.expand(),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: lineColor),
                              ),
                              //color: Colors.green
                            ),
                            child: const Text('オープニング'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: itemHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: lineColor),
                            ),
                          ),
                          child: const Text('オープニング'),
                        ),
                      ),
                      const Text('data'),
                    ],
                  ),
                ),

              ],
            ),
          ),
          DecoratedContainer(
            child: Row(
              children: [
                Column(
                  children: const [
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  ],
                ),
                Column(
                  children: const [
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: lineColor),
                        ),
                      ),
                      child: const Text('オープニング'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

final isCallWhenAlert = StateProvider<bool>((ref) => false);
