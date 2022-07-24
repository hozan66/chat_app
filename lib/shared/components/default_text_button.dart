import '../styles/my_colors.dart';
import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;

  const DefaultTextButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = MyColors.myPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
