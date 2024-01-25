import 'dart:io';
import 'package:blessmate/modules/productscreen.dart';
import 'package:blessmate/modules/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../main.dart';
import 'add_after_signu.dart';
import 'categoryscreen.dart';
import 'chat.dart';
import 'dark.dart';
import 'drawer.dart';
import 'explore.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

final ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

class _BottomNavState extends State<BottomNav> {
  int currentindex = 4;

  List<Widget> screens = [
    ProfileScreen(),
    CommunityScreen(),
    Explore(),
    ChatScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "حساب تعريفي",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "تعيينات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "يستكشف",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "محادثه",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
        ],
      ),
    );
  }
}
