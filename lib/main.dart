import 'package:flutter/material.dart';
import 'package:hk/auth/login.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:hk/theme/theme.dart';
import 'package:hk/values/colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstSliderPages/sliders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool checkSlider = sp.getBool('firstpage') ?? false;
  bool loginType = sp.getBool('login') ?? false;
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("1d5fd97b-8457-4768-a62d-5dcd8015ed6b");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  OneSignal.Notifications.addClickListener((value) {
    // navigatorKey.currentState!.push(
    //   MaterialPageRoute(
    //     builder: (context) => const Notifications(),
    //   ),
    // );
  });

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
      home: checkSlider ? Home() : sliders(),
    ),
  );
}
