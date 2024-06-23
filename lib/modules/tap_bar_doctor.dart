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
import 'package:shared_preferences/shared_preferences.dart';

class TabBarScreen extends StatefulWidget {
  final int therapistId;
  const TabBarScreen({Key? key, required this.therapistId}) : super(key: key);



  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstName') ?? '';
      _lastName = prefs.getString('lastName') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }
  String _selectedLanguage = 'ar';

  String extractUsername(String email) {
    List<String> parts = email.split("@");
    String username = parts[0];
    username = username.replaceAll("\\d", "");
    return username;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "مرحبآ".tr,
                      style: TextStyle(fontSize: 15, color: Colors.black),
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
                  extractUsername(_email),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),

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
        ),),
        body: Column(children: [
          TabBar(
            labelColor: HexColor('00B4D8'),
            indicatorColor: HexColor('00B4D8'),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child:Text(
                  "الملف الشخصى",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                     ),
                ),
              ),
              Tab(
                child: Text(
                  "الصفحة الرئيسية".tr,
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
              ProfileDoctorScreen(therapistId: widget.therapistId),
              HomeDoctorScreen(therapistId: widget.therapistId),
            ]),
          ),
        ]
        ),
      ),
    );
  }
}
