import 'package:blessmate/language/translate.dart';
import 'package:blessmate/modules/notification.dart';
import 'package:blessmate/modules/onboardingscreen.dart';
import 'package:blessmate/modules/profile1.dart';
import 'package:blessmate/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'modules/add_after_signu.dart';
import 'modules/bottom_nav.dart';
import 'modules/doctor_details_screen.dart';
import 'modules/id.dart';
import 'modules/logres.dart';
import 'modules/signindoctor.dart';
import 'modules/signup.dart';
import 'modules/login.dart';
import 'modules/dark.dart';
import 'modules/initsreen.dart';
import 'modules/signupdoc.dart';
import 'modules/tap_bar_doctor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<ValueNotifier<MyThemeMode>>(
      create: (_) => ValueNotifier<MyThemeMode>(MyThemeMode.light),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ValueNotifier<MyThemeMode>>(context).value;
    const Color mainColor = Color(0xFF00B4D8);
    ThemeData selectedTheme;
    switch (themeMode) {
      case MyThemeMode.light:
        selectedTheme = lightTheme;
        break;
      case MyThemeMode.dark:
        selectedTheme = darkTheme;
        break;
      case MyThemeMode.third:
        selectedTheme = thirdTheme;
        break;
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme,
      home: DoctorDetailsScreen(),
      translations: Translation(),
      locale: Locale('ar'),
      fallbackLocale: Locale('ar'),
    );
  }
}
