import 'package:flutter/material.dart';

import 'border.dart';
import 'design_rules.dart';

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
