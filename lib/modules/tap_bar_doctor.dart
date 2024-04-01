import 'package:blessmate/modules/add_after_signu.dart';
import 'package:blessmate/modules/change_password.dart';
import 'package:blessmate/modules/dark.dart';
import 'package:blessmate/modules/home_doctor.dart';
import 'package:blessmate/modules/notification.dart';
import 'package:blessmate/modules/notification_doctor.dart';
import 'package:blessmate/modules/profile_doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  String _selectedLanguage = 'ar';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 65,
              margin: EdgeInsets.only(right: 5, left: 5, top: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: Image(
                height: 55,
                width: 70,
                image: AssetImage(
                  "assets/images/img_15.png",
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "مرحبآ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image(
                      height: 20,
                      width: 20,
                      image: AssetImage(
                        "assets/images/img_16.png",
                      ),
                    ),
                  ],
                ),
                Text(
                  "د. عادل عيسى",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationDoctorScreen()));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Image(
                        width: 30,
                        height: 30,
                        image: AssetImage("assets/images/img_17.png"))
                  ],
                )),
          ],
        )),
        body: Column(children: [
          TabBar(
            labelColor: HexColor('00B4D8'),
            indicatorColor: HexColor('00B4D8'),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  "الملف الشخصي",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "الصفحة الرئيسية",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              ProfileDoctorScreen(),
              HomeDoctorScreen(),
            ]),
          ),
        ]
        ),
      ),
    );
  }
}
