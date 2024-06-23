import 'package:blessmate/modules/productscreen.dart';
import 'package:blessmate/modules/profile1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appointment_view.dart';
import 'chat.dart';
import 'explore.dart';

class BottomNav extends StatefulWidget {
  final int? patientId;

  BottomNav({Key? key, this.patientId}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentindex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(),
      Explore(),
      ChatScreen(),
      AppointmentView(patientId: widget.patientId), // تمرير patientId هنا
      ProfileScreen1(),
    ];
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
            icon: Icon(Icons.home_outlined),
            label: "الرئيسية".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "استكشف".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_unread_chat_alt_outlined),
            label: "المحادثه".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_sharp),
            label: "الحجوزات".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "الملف الشخصي".tr,
          ),
        ],
      ),
    );
  }
}
