import 'package:flutter/material.dart';

import '../constants/default_values.dart';
import '../styles/my_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;
  final EdgeInsets padding;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = MyColors.myPrimaryColor,
    this.padding = const EdgeInsets.all(myDefaultPadding * 0.75),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      padding: padding,
      color: color,
      minWidth: double.infinity,
      onPressed: press,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    );
  }
}
