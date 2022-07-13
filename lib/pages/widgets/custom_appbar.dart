import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key, required this.leadingText, required this.mainTitle, required this.trailingText})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String leadingText;
  final String mainTitle;
  final String trailingText;

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
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
      title: Text(mainTitle),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            AppBar();
          },
          child: Text(
            trailingText,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}