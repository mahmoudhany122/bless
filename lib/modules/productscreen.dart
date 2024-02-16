import 'package:blessmate/modules/musiq.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:blessmate/modules/imagine.dart';

class HomeScreen extends StatelessWidget {
  List ScreensName = ['موسيقى'.tr, 'التامل'.tr, 'اليوجا'.tr, 'الكل'.tr];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(),
      length: ScreensName.length,
      initialIndex: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your App Title'),
          bottom: TabBar(
            isScrollable: true,
            physics: BouncingScrollPhysics(),
            indicatorColor: HexColor('00B4D8'),
            indicator: BoxDecoration(
              color: HexColor('00B4D8'),
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              for (int i = 0; i < ScreensName.length; i++)
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
                    child: Text('${ScreensName[i]}'),
                  ),
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: Text('Screen 2 Content'),
              ),
            ),
            ExerciseScreen(),
            Musiq(),
            Container(
              child: Center(
                child: Text('Screen 4 Content'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
