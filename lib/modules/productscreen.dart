import 'package:blessmate/modules/musiq.dart';
import 'package:blessmate/modules/notification.dart';
import 'package:blessmate/modules/yoga.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:blessmate/modules/imagine.dart';
import 'all.dart';
import 'gem.dart';
import 'package:get/get.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> screensName = ['الكل'.tr, 'موسيقى'.tr, 'التامل'.tr, 'اليوجا'.tr, 'تمارين'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          screensName[_selectedIndex], // Update the title based on selected tab
          style: Theme.of(context).textTheme.bodyText1,
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
                  Gym(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
