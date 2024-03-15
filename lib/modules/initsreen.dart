import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav.dart';
import 'login.dart';
import 'onboardingscreen.dart';
// استيراد شاشة تسجيل الدخول

class LogoScreen extends StatefulWidget {
  LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      _checkLoginStatus(); // التحقق من حالة تسجيل الدخول بعد فترة زمنية
    });
  }

  // التحقق من حالة تسجيل الدخول المحلية
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // إذا كان المستخدم قد سجل الدخول بالفعل، قم بتوجيهه إلى شاشة BottomNav
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      );
    } else {
      // إذا لم يكن المستخدم قد سجل الدخول بعد، قم بتوجيهه إلى شاشة تسجيل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(),
              child: Image.asset(
                "assets/images/img_2.png",
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
            ),
            Text(
              'Bliss Mate',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'You are not alone',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
