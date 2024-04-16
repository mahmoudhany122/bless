import 'package:blessmate/modules/musiq.dart';
import 'package:blessmate/modules/yoga.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:blessmate/modules/imagine.dart';
import 'all.dart';
import 'call.dart';
import 'chatitem.dart';
import 'gem.dart';
import 'package:get/get.dart';



class MyTabbedScreen extends StatefulWidget {
  @override
  State<MyTabbedScreen> createState() => _MyTabbedScreenState();
}

class _MyTabbedScreenState extends State<MyTabbedScreen> {
  List<String> screensName = ['الدردشة','المكالمات'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              labelColor: Colors.black,

              tabs: [
                for (int i = 0; i < screensName.length; i++)
                  Tab(
                    child: Container(
                      width: 110,
                      alignment: Alignment.center,
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
                  SCREENMESSENGER(),
                  CallsScreen(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
