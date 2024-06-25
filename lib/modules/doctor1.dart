import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeDoctor1 extends StatefulWidget {
  const HomeDoctor1({super.key});

  @override
  State<HomeDoctor1> createState() => _HomeDoctor1State();
}

class _HomeDoctor1State extends State<HomeDoctor1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("تاريخ الاستشارات".tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
          centerTitle: true, ),

    );
  }
}
