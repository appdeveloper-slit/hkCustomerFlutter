import 'package:flutter/material.dart';
import 'package:hk/auth/login.dart';
import 'package:hk/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firstSliderPages/sliders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool checkSlider = sp.getBool('firstpage') ?? false;

  runApp(
    MaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!);
      },
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: sliders(),
      // checkSlider ? loginPage() : sliders(),
    ),
  );
}
