import 'package:blessmate/modules/musiq.dart';
import 'package:blessmate/modules/notification.dart';
import 'package:blessmate/modules/yoga.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:blessmate/modules/imagine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'all.dart';
import 'gem.dart';
import 'package:get/get.dart';

import 'notification_doctor.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> screensName = ['الكل'.tr, 'موسيقى'.tr, 'التامل'.tr, 'اليوجا'.tr ];
  int _selectedIndex = 0;
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

  String extractUsername(String email) {
    List<String> parts = email.split("@");
    String username = parts[0];
    username = username.replaceAll("\\d", "");
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
        leading: IconButton(
          icon: Icon(Icons.notifications_none, color: HexColor('00B4D8')),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(),
                ));
          },
        ),
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
                      style:  Theme.of(context).textTheme.headline6,

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
                  style:  Theme.of(context).textTheme.headline6,

                ),

              ],
            ),
          ],
        ),

        centerTitle: true,
      ),
      body: DefaultTabController(
        length: screensName.length,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              indicatorColor: HexColor('00B4D8'),
              padding: EdgeInsetsDirectional.symmetric(horizontal: 5),
              indicator: BoxDecoration(
                color: HexColor('00B4D8'),
                borderRadius: BorderRadius.circular(20),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                for (int i = 0; i < screensName.length; i++)
                  Tab(
                    child: Container(
                      width: 110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor('00B4D8'),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${screensName[i]}'),
                    ),
                  ),
              ],
              onTap: (index) {
                // Set the selected index and update the AppBar title
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: TabBarView(
                children: [
                  All(),
                  Musiq(),
                  Yoga(),
                  ExerciseScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
