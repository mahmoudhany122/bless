import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'onboardingscreen.dart';

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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoardingScreen(),
          ));
    });
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
