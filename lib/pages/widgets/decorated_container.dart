import 'package:flutter/material.dart';

import 'border.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: lineColor),
        ),
      ),
      child: child,
    );
  }
}