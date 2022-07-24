import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/my_colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

//push and replacement
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      // If route is returning false replace all pages otherwise just push
      (route) => false,
    );

Widget buildLoadingIndicator({final Color color = MyColors.myPrimaryColor}) {
  return Center(
      child: CircularProgressIndicator(
    color: color,
  ));
}

AppBar defaultAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
    ),
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      // Show Long toast for 5 sec
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
