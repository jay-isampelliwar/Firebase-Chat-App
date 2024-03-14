import 'package:flutter/material.dart';

import 'res/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: "Nunito",
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.grey.shade300,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
    ),
  );
}
