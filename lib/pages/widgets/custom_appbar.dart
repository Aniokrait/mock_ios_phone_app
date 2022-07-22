import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/phone_type.dart';
import '../new_contact_page.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.leadingText,
      required this.mainTitle,
      required this.trailingText})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String leadingText;
  final String mainTitle;
  final String trailingText;

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leadingWidth: 100,
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          leadingText,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      title: Center(
        child: Text(mainTitle),
      ),
      actions: [
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              AppBar();
            },
            child: Text(
              trailingText,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
