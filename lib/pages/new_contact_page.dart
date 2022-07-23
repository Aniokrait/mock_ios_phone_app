import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/contact_item.dart';
import 'package:mock_ios_phone_app/pages/widgets/add_line_row.dart';
import 'package:mock_ios_phone_app/pages/widgets/custom_appbar.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_container.dart';
import 'package:mock_ios_phone_app/pages/widgets/decorated_text_form_field.dart';
import 'package:mock_ios_phone_app/pages/widgets/design_rules.dart';
import 'package:collection/collection.dart';

import '../data/birthday_type.dart';
import '../data/date_type.dart';
import '../data/email_type.dart';
import '../data/instant_message_type.dart';
import '../data/phone_type.dart';
import '../data/sns_type.dart';
import '../data/url_type.dart';
import '../model/ring_tone_model.dart';
import 'dial_page.dart';

class NewContactPage extends ConsumerWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingText: 'キャンセル',
        mainTitle: '新規連絡先',
        trailingText: 'OK',
        trailingAction: () {
          Navigator.pop(context);
        },
      ),
      body: const _ContactForm(),
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
                SizedBox(
                  height: itemHeight,
                ),
                // メール
                _EmailField(),
                SizedBox(
                  height: itemHeight,
                ),
                // 着信音
                _RingTone(),
                SizedBox(
                  height: itemHeight,
                ),
                // メッセージ

                // URL
                _UrlField(),
                SizedBox(
                  height: itemHeight,
                ),
                // 住所

                // 誕生日
                _BirthdayField(),
                SizedBox(
                  height: itemHeight,
                ),
                // 日付
                _DateField(),
                SizedBox(
                  height: itemHeight,
                ),
                // 関係

                // SNS
                _SnsField(),
                SizedBox(
                  height: itemHeight,
                ),
                // インスタントメッセージ
                _InstantMessageField(),
                SizedBox(
                  height: itemHeight,
                ),
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
                        ref
                            .read(phoneNumbersTextEditControllers)
                            .removeAt(index);
                      },
                    ),
                    Text(element.type.name),
                    const Icon(Icons.chevron_right),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: '電話'),
                        controller:
                            ref.watch(phoneNumbersTextEditControllers)[index],
                      ),
                    ),
                    //Text(element.value),
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
            labelValues: PhoneType.values,
            contactItem: ContactItem.phone,
            textEditControllers: phoneNumbersTextEditControllers,
          ),
        ],
      ),
    );
  }
}

class _EmailField extends ConsumerWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> inputFields = ref
        .watch(emailTypesProvider)
        .mapIndexed(
          (index, element) => Container(
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
                      ref.read(emailTypesProvider.notifier).removeAt(index);
                      ref.read(emailTextEditControllers).removeAt(index);
                    },
                  ),
                  Text(element.type.name),
                  const Icon(Icons.chevron_right),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'メール'),
                      controller: ref.watch(emailTextEditControllers)[index],
                    ),
                  ),
                  //Text(element.value),
                ],
              ),
            ),
          ),
        )
        .toList();

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          //メールを追加行
          AddLineRow(
            title: 'メールを追加',
            provider: emailTypesProvider,
            labelValues: EmailType.values,
            contactItem: ContactItem.email,
            textEditControllers: emailTextEditControllers,
          ),
        ],
      ),
    );
  }
}

class _RingTone extends ConsumerWidget {
  const _RingTone({Key? key}) : super(key: key);

  String makeRingToneString(WidgetRef ref, RingToneModel? ringToneModel) {
    //着信音画面で選択した音をresultに代入。初期表示時は「デフォルト」
    String result = ref.watch(ringToneText)?.targetSound1?.toString() ??
        ref.watch(ringToneText)?.targetSound2.toString() ??
        'デフォルト';

    //着信音画面でデフォルトを選んだときはRingToneModelがnullでないので改めてチェック
    if (ringToneModel?.isDefaultSound ?? false) {
      result = 'デフォルト';
    }

    //緊急時に鳴らすフラグが立っている場合、改行して「緊急時に鳴らす」も表示する
    //ただしデフォルトの場合は、「デフォルト」を消し「緊急時に鳴らす」を改行なしで表示する
    if (ringToneModel?.isCallWhenAlert ?? false) {
      if (ringToneModel?.isDefaultSound ?? false) {
        result = '緊急時に鳴らす';
      } else {
        result += '\n緊急時に鳴らす';
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RingToneModel? result;

    return DecoratedContainer(
      child: SizedBox(
        height: itemHeight,
        child: Row(
          children: [
            const Text('着信音'),
            const SizedBox(
              width: 15,
            ),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 0),
              onPressed: () async {
                result = await Navigator.pushNamed(context, 'ring-tone')
                    as RingToneModel;

                ref.read(ringToneText.notifier).state = result;
              },
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  makeRingToneString(ref, ref.watch(ringToneText)),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
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

class _UrlField extends ConsumerWidget {
  const _UrlField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> inputFields = ref
        .watch(urlTypesProvider)
        .mapIndexed(
          (index, element) => Container(
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
                      ref.read(urlTypesProvider.notifier).removeAt(index);
                      ref.read(urlTextEditControllers).removeAt(index);
                    },
                  ),
                  Text(element.type.name),
                  const Icon(Icons.chevron_right),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'URL'),
                      controller: ref.watch(urlTextEditControllers)[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          //URLを追加行
          AddLineRow(
            title: 'URLを追加',
            provider: urlTypesProvider,
            labelValues: UrlType.values,
            contactItem: ContactItem.url,
            textEditControllers: urlTextEditControllers,
          ),
        ],
      ),
    );
  }
}

class _BirthdayField extends ConsumerWidget {
  const _BirthdayField({Key? key}) : super(key: key);

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> inputFields = ref
        .watch(birthdayTypesProvider)
        .mapIndexed(
          (index, element) => Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: index < 1
                    ? const BorderSide(color: lineColor)
                    : BorderSide.none,
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
                      ref.read(birthdayTypesProvider.notifier).removeAt(index);
                    },
                  ),
                  Text(element.type.name),
                  const Icon(Icons.chevron_right),
                  // Expanded(
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.datetime,
                  //     decoration: const InputDecoration(
                  //         border: InputBorder.none, hintText: '日付'),
                  //     controller: ref.watch(birthdayTextEditControllers)[index],
                  //   ),
                  // ),

                  // Expanded(
                  //   child: CupertinoDatePicker(
                  //     mode: CupertinoDatePickerMode.date,
                  //     initialDateTime: DateTime.now(),
                  //     onDateTimeChanged: (DateTime value) {},
                  //   ),
                  // )
                  CupertinoButton(
                    // このpadding設定がないと字が見切れるFlutterのクソ仕様
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '${ref.watch(birthdayTypesProvider)[index].value.month}月${ref.watch(birthdayTypesProvider)[index].value.day}日',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () => _showDialog(
                      context,
                      CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          ref
                              .read(birthdayTypesProvider.notifier)
                              .updateDate(index, newDate);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          //誕生日を追加行
          //最大二行まで
          if (inputFields.length < 2)
            AddLineRow(
              title: '誕生日を追加',
              provider: birthdayTypesProvider,
              labelValues: BirthdayType.values,
              contactItem: ContactItem.birthday,
              textEditControllers: birthdayTextEditControllers,
            ),
        ],
      ),
    );
  }
}

class _DateField extends ConsumerWidget {
  const _DateField({Key? key}) : super(key: key);

  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> inputFields = ref
        .watch(dateTypesProvider)
        .mapIndexed(
          (index, element) => Container(
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
                      ref.read(dateTypesProvider.notifier).removeAt(index);
                    },
                  ),
                  Text(element.type.name),
                  const Icon(Icons.chevron_right),
                  CupertinoButton(
                    // このpadding設定がないと字が見切れるFlutterのクソ仕様
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '${ref.watch(dateTypesProvider)[index].value.month}月${ref.watch(dateTypesProvider)[index].value.day}日',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () => _showDialog(
                      context,
                      CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          ref
                              .read(dateTypesProvider.notifier)
                              .updateDate(index, newDate);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          //日付を追加行
          AddLineRow(
            title: '日付を追加',
            provider: dateTypesProvider,
            labelValues: DateType.values,
            contactItem: ContactItem.date,
            textEditControllers: dateTextEditControllers,
          ),
        ],
      ),
    );
  }
}

class _SnsField extends ConsumerWidget {
  const _SnsField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> inputFields = ref
        .watch(snsTypesProvider)
        .mapIndexed(
          (index, element) => Container(
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
                      ref.read(snsTypesProvider.notifier).removeAt(index);
                      ref.read(snsTextEditControllers).removeAt(index);
                    },
                  ),
                  Text(element.type.name),
                  const Icon(Icons.chevron_right),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'SNSプロフィール'),
                      controller: ref.watch(snsTextEditControllers)[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          //SNSを追加行
          AddLineRow(
            title: 'SNSを追加',
            provider: snsTypesProvider,
            labelValues: SnsType.values,
            contactItem: ContactItem.sns,
            textEditControllers: snsTextEditControllers,
          ),
        ],
      ),
    );
  }
}

class _InstantMessageField extends ConsumerWidget {
  const _InstantMessageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> inputFields = ref
        .watch(instantMessageTypesProvider)
        .mapIndexed(
          (index, element) => Container(
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
                      ref
                          .read(instantMessageTypesProvider.notifier)
                          .removeAt(index);
                      ref.read(instantMsgTextEditControllers).removeAt(index);
                    },
                  ),
                  Text(element.type.name),
                  const Icon(Icons.chevron_right),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'メッセージ'),
                      controller:
                          ref.watch(instantMsgTextEditControllers)[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();

    return DecoratedContainer(
      child: Column(
        children: [
          ...inputFields,
          //インスタントメッセージを追加行
          AddLineRow(
            title: 'インスタントメッセージを追加',
            provider: instantMessageTypesProvider,
            labelValues: InstantMessageType.values,
            contactItem: ContactItem.instantMessage,
            textEditControllers: instantMsgTextEditControllers,
          ),
        ],
      ),
    );
  }
}

final phoneNumbersTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController(text: ref.read(inputPhoneNumber))]);
final emailTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController()]);
final urlTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController()]);
// TODO 密結合したせいで消せなくなった。
final birthdayTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController()]);
final dateTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController()]);
final snsTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController()]);
final instantMsgTextEditControllers =
    StateProvider.autoDispose<List<TextEditingController>>(
        (ref) => [TextEditingController()]);

final ringToneText = StateProvider<RingToneModel?>((ref) => null);
