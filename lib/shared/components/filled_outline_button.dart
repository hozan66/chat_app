import 'package:flutter/material.dart';

import '../styles/my_colors.dart';

class FillOutlineButton extends StatelessWidget {
  final bool isFilled;
  final VoidCallback press; // VoidCallback passing function without parameter
  final String text;

  const FillOutlineButton({
    Key? key,
    this.isFilled = true,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 2.0 : 0.0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? MyColors.myContentColorLightTheme : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
