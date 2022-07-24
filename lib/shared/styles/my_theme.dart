import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';

// By default flutter provide for us light and dark theme
// We just modify it as our need

class MyTheme {
  // This is our main focus
  // Let's apply light and dark theme on our app
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: MyColors.myPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: MyColors.myContentColorLightTheme),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: MyColors.myContentColorLightTheme),
      colorScheme: const ColorScheme.light(
        primary: MyColors.myPrimaryColor,
        secondary: MyColors.mySecondaryColor,
        error: MyColors.myErrorColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: MyColors.myContentColorLightTheme.withOpacity(0.7),
        unselectedItemColor:
            MyColors.myContentColorLightTheme.withOpacity(0.32),
        selectedIconTheme: const IconThemeData(color: MyColors.myPrimaryColor),
        showUnselectedLabels: true,
      ),
    );
  }

  // Now let's add dark theme on our app
  static ThemeData darkThemeData(BuildContext context) {
    // By default flutter provide us light and dark theme
    // We just modify it as our need
    return ThemeData.dark().copyWith(
      primaryColor: MyColors.myPrimaryColor,
      scaffoldBackgroundColor: MyColors.myContentColorLightTheme,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: MyColors.myContentColorDarkTheme),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: MyColors.myContentColorDarkTheme),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: MyColors.myPrimaryColor,
        secondary: MyColors.mySecondaryColor,
        error: MyColors.myErrorColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MyColors.myContentColorLightTheme,
        selectedItemColor: Colors.white70,
        unselectedItemColor: MyColors.myContentColorDarkTheme.withOpacity(0.32),
        selectedIconTheme: const IconThemeData(color: MyColors.myPrimaryColor),
        showUnselectedLabels: true,
      ),
    );
  }

  static const AppBarTheme appBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0.0,
    backgroundColor: MyColors.myPrimaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: MyColors.myPrimaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}
