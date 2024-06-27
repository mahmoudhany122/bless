import 'package:blessmate/language/translate.dart';
import 'package:blessmate/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'modules/bottom_nav.dart';
import 'modules/initsreen.dart';
import 'modules/profile1.dart';


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

    ThemeData selectedTheme;
    if (themeMode == MyThemeMode.light) {
      selectedTheme = lightTheme;
    } else if (themeMode == MyThemeMode.dark) {
      selectedTheme = darkTheme;
    } else {
      selectedTheme = lightTheme;
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme,

      home:LogoScreen(),
      translations: Translation(),
      locale: Locale('ar'),
      fallbackLocale: Locale('ar'),
    );
  }
}
