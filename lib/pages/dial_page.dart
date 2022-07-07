import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _phoneNumber = StateProvider<String>((ref) => '');
final _visibleAddNumText = StateProvider<bool>((ref) => false);

class DialPage extends ConsumerWidget {
  DialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        carrierButton(),
        phoneNumsText(ref),
        Visibility(
          visible: ref.watch(_visibleAddNumText),
          child: addToContactsButton(),
        ),
        const Spacer(),
        dialRow(firstRowDials(ref)),
        dialRow(secondRowDials(ref)),
        dialRow(thirdRowDials(ref)),
        dialRow(fourthRowDials(ref)),
        fifthRow(ref),
      ],
    );
  }

  /// button to select a mobile carrier
  ElevatedButton carrierButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () => {},
      child: const Text('楽天モバイル'),
    );
  }

  /// text field of the input phone number
  Text phoneNumsText(WidgetRef ref) {
    int fontSize = 32;

    // 打ち込まれた数字列を取得する(現在値)
    String phoneNumber = ref.watch(_phoneNumber);
    int numlength = phoneNumber.length;
    // 表示用は別変数にする(先頭は...で置き換えるが内部的には全桁保持しておくため)
    String dispPhoneNum = phoneNumber;

    if (15 <= numlength && numlength <= 20) {
      // 15文字目〜20文字目まで少しづつ小さくなっていく
      // 桁数が増えるほど文字は小さくなる
      fontSize = fontSize - (14 - numlength).abs();
    } else if (21 <= numlength) {
      // リビルド時にフォントが元の大きさに戻ってしまうので、小さいままにしておく
      fontSize = 26;

      // 21文字目からは先頭文字列が...に置き換わる
      int leadingPos = (20 - numlength).abs();
      dispPhoneNum = '...${phoneNumber.substring(leadingPos)}';
    }

    return Text(
      dispPhoneNum,
      style: TextStyle(fontSize: fontSize.toDouble()),
    );
  }

  /// button to add phone number to contacts
  TextButton addToContactsButton() {
    return TextButton(
      onPressed: () => {},
      child: const Text(
        '番号を追加',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Container dialRow(List<Widget> dialButtons) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 14, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dialButtons,
      ),
    );
  }

  List<ElevatedButton> firstRowDials(WidgetRef ref) {
    return [
      // 1は半角スペースがないとなぜか上寄せになる。
      dialButton('1', ' ', ref.read),
      dialButton('2', 'ABC', ref.read),
      dialButton('3', 'DEF', ref.read),
    ];
  }

  List<ElevatedButton> secondRowDials(WidgetRef ref) {
    return [
      dialButton('4', 'GHI', ref.read),
      dialButton('5', 'JKL', ref.read),
      dialButton('6', 'MNO', ref.read),
    ];
  }

  List<ElevatedButton> thirdRowDials(WidgetRef ref) {
    return [
      dialButton('7', 'PQRS', ref.read),
      dialButton('8', 'TUV', ref.read),
      dialButton('9', 'WXYZ', ref.read),
    ];
  }

  List<ElevatedButton> fourthRowDials(WidgetRef ref) {
    return [
      dialButton('*', '', ref.read),
      dialButton('0', '+', ref.read),
      dialButton('#', '', ref.read),
    ];
  }

  Container fifthRow(WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 70,
            height: 70,
          ),
          handsetButton(),
          backspaceButton(ref),
        ],
      ),
    );
  }

  /// returns round shaped dial button
  ElevatedButton dialButton(String dialChar, String alphabet, Reader read) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[350],
        elevation: 0,
        shape: const CircleBorder(),
        minimumSize: const Size(70, 70),
      ),
      onPressed: () {
        read(_phoneNumber.notifier).state += dialChar;
        read(_visibleAddNumText.notifier).state = true;
      },
      //以下ボタン内のテキストの設定
      child: () {
        return RichText(
          textAlign: TextAlign.center,
          text: dialButtonText(dialChar, alphabet),
        );
      }(),
    );
  }

  TextSpan dialButtonText(String dialChar, String alphabet) {
    double dialFontSize = 32;
    const double alphabetFontSize = 12;
    const fontColor = Colors.black87;

    if (dialChar == '*') {
      dialFontSize = 54;
    }

    final List<InlineSpan> textSpanList = [];
    // ＊が上側に寄ってしまうのを回避
    if (dialChar == '*') {
      textSpanList.add(
        const TextSpan(
          text: '\n',
          style: TextStyle(fontSize: alphabetFontSize, color: fontColor),
        ),
      );
    }

    // 数字行
    textSpanList.add(TextSpan(
      text: dialChar,
      style: TextStyle(fontSize: dialFontSize, color: fontColor),
    ));

    // 記号以外の場合のみ2行目用のTextSpanを追加
    if (dialChar != '*' && dialChar != '#') {
      textSpanList.add(TextSpan(
        text: '\n$alphabet',
        style: const TextStyle(fontSize: alphabetFontSize, color: fontColor),
      ));
    }

    return TextSpan(children: textSpanList);
  }

  /// returns handset button
  ElevatedButton handsetButton() {
    return ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: const CircleBorder(),
        minimumSize: const Size(70, 70),
      ),
      child: const Icon(
        Icons.phone,
        size: 36,
      ),
    );
  }

  /// returns buck space button
  Container backspaceButton(WidgetRef ref) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.only(left: 19, top: 17),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {
              String phoneNum = ref.read(_phoneNumber);
              if (phoneNum.isEmpty) {
                return;
              }
              String trimmed = phoneNum.substring(0, phoneNum.length - 1);
              ref.read(_phoneNumber.notifier).state = trimmed;

              // 「番号を追加」を非表示に
              if (trimmed.isEmpty) {
                ref.read(_visibleAddNumText.notifier).state = false;
              }
            },
            icon: Icon(
              Icons.backspace,
              size: 30,
              color: Colors.grey[350],
            ),
          ),
        ],
      ),
    );
  }
}
