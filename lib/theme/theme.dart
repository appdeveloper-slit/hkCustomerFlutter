

import 'package:flutter/material.dart';
import 'package:hk/values/colors.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Clr().background,
    primary: Clr().black,
  )
); 

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(221, 35, 35, 35),
    primary: Clr().white,
  )
);