import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/pages/widgets/custom_appbar.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_container.dart';
import 'package:mock_ios_phone_app/pages/widgets/design_rules.dart';

import '../data/notification_sound.dart';
import '../data/ring_tone.dart';
import '../model/ring_tone_model.dart';

class MessagePage extends ConsumerWidget {
  const MessagePage({Key? key}) : super(key: key);

  ///完了ボタン押下時のアクション
  void returnRingToneConfig(BuildContext context, Reader read) {
    var compositeList = [
      RingTone.opening,
      ...NotificationSound.values,
      ...RingTone.values,
    ];
    bool isCall = read(isCallWhenAlert_Message);

    RingToneModel result;
    if (compositeList[read(selectedRingtone_Message)] is RingTone) {
      result = RingToneModel(
          targetSound1:
              compositeList[read(selectedRingtone_Message)] as RingTone,
          isCallWhenAlert: isCall);
    } else {
      result = RingToneModel(
          targetSound2: compositeList[read(selectedRingtone_Message)]
              as NotificationSound,
          isCallWhenAlert: isCall);
    }

    //デフォルトサウンドか？
    result.isDefaultSound = read(selectedRingtone_Message) == 0;

    Navigator.pop(
      context,
      result,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'キャンセル',
        mainTitle: 'メッセージ',
        trailingText: '完了',
        trailingAction: () {
          returnRingToneConfig(context, ref.read);
        },
      ),
      body: const _MessageForm(),
    );
  }
}

class _MessageForm extends ConsumerWidget {
  const _MessageForm({Key? key}) : super(key: key);

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
                  value: ref.watch(isCallWhenAlert_Message),
                  onChanged: (bool newValue) {
                    ref.read(isCallWhenAlert_Message.notifier).state = newValue;
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
              child: InkWell(
                onTap: () {
                  ref.read(selectedRingtone_Message.notifier).state = 0;
                },
                child: Row(
                  children: [
                    ref.watch(selectedRingtone_Message) == 0
                        ? const Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : const SizedBox(width: 24),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(RingTone.opening.name),
                  ],
                ),
              ),
            ),
          ),

          ///通知音
          Container(
            margin: const EdgeInsets.only(top: 18),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              '通知音',
              style: TextStyle(fontSize: 12),
            ),
          ),
          DecoratedContainer(
            child: Column(
              children: [
                for (int i = 0; i < NotificationSound.values.length; i++) ...{
                  _RingtoneRow(
                    index: i,
                    beforeArrayLength: 1,
                    ringToneName: NotificationSound.values[i].name,
                  ),
                }
              ],
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
                for (int i = 0; i < RingTone.values.length; i++) ...{
                  _RingtoneRow(
                    index: i,
                    beforeArrayLength: 1 + NotificationSound.values.length,
                    ringToneName: RingTone.values[i].name,
                  ),
                }
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RingtoneRow extends ConsumerWidget {
  const _RingtoneRow({
    Key? key,
    required this.index,
    required this.beforeArrayLength,
    required this.ringToneName,
  }) : super(key: key);

  final int index;
  final int beforeArrayLength;
  final String ringToneName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isNashiRow = index + beforeArrayLength == 1;
    return SizedBox(
      height: itemHeight,
      child: InkWell(
        onTap: () {
          ref.read(selectedRingtone_Message.notifier).state =
              index + beforeArrayLength;
        },
        child: Container(
          //通知音のなしの行だけ下線ボーダーをひく
          decoration: isNashiRow
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black38, width: 1.5),
                  ),
                )
              : null,
          child: Row(
            children: [
              ref.watch(selectedRingtone_Message) == index + beforeArrayLength
                  ? const Icon(
                      Icons.check,
                      color: Colors.blue,
                    )
                  : const SizedBox(width: 24),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: !isNashiRow
                      ? const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: lineColor),
                          ),
                        )
                      : null,
                  child: Text(ringToneName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final isCallWhenAlert_Message = StateProvider<bool>((ref) => false);
final selectedRingtone_Message = StateProvider<int>((ref) => 0);
