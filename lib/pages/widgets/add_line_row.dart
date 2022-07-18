import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mock_ios_phone_app/data/birthday_type.dart';
import 'package:mock_ios_phone_app/data/contact_item.dart';
import 'package:mock_ios_phone_app/data/data_type.dart';
import 'package:mock_ios_phone_app/data/date_type.dart';
import 'package:mock_ios_phone_app/data/email_type.dart';
import 'package:mock_ios_phone_app/data/instant_message_type.dart';
import 'package:mock_ios_phone_app/data/sns_type.dart';
import 'package:mock_ios_phone_app/data/url_type.dart';
import '../../data/abst_state_notifier.dart';
import '../../data/phone_type.dart';
import '../new_contact_page.dart';
import 'design_rules.dart';

class AddLineRow<E extends Enum> extends ConsumerWidget {
  const AddLineRow(
      {Key? key,
      required this.title,
      required this.provider,
      required this.labelValues,
      required this.contactItem,
      required this.textEditControllers})
      : super(key: key);

  final String title;
  final AutoDisposeStateNotifierProvider<AbstStateNotifier, List> provider;
  final List<E> labelValues;
  final ContactItem contactItem;
  final AutoDisposeStateProvider textEditControllers;

  void addLine<T>(Reader read) {
    var currentRows = read(provider.notifier);

    // Enumを走査し、まだ追加されていないタイプを追加する
    bool isAdded = false;
    for (E e in labelValues) {
      if (currentRows.contains(e)) {
        continue;
      } else {
        currentRows.add(createDataType(e));
        isAdded = true;
        break;
      }
    }

    // すべてのタイプがすでに追加されている場合は、Enumの１番目のタイプを追加する
    if (!isAdded) {
      currentRows.add(createDataType(labelValues[0]));
    }

    read(textEditControllers.notifier).state.add(TextEditingController());
  }

  DataType createDataType(E targetType) {
    switch (contactItem) {
      case ContactItem.phone:
        return NumberOfPhoneType(type: targetType as PhoneType, value: '');
      case ContactItem.email:
        return AddressOfEmailType(type: targetType as EmailType, value: '');
      case ContactItem.url:
        return UrlOfUrlType(type: targetType as UrlType, value: '');
      case ContactItem.birthday:
        return DateOfBirthdayType(type: targetType as BirthdayType, value: DateTime.now());
      case ContactItem.date:
        return DateOfDateType(type: targetType as DateType, value: DateTime.now());
      case ContactItem.sns:
        return ProfileOfSnsType(type: targetType as SnsType, value: '');
      case ContactItem.instantMessage:
        return MessageOfInstantMsgType(type: targetType as InstantMessageType, value: '');
      default:
        throw UnimplementedError();
    }
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
