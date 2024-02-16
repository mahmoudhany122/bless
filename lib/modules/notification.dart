import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

var myColor = HexColor('00B4D8');

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    bool _value = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("الإشعارات".tr,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 24),),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("نغمة المحادثات".tr,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyText1),

                          Text("تشغيل الأصوات للرسائل الواردة والصادرة".tr,
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                      Spacer(),
                      Switch(
                          value: _value,
                          activeColor: myColor,
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white,
                          inactiveThumbColor: myColor,
                          onChanged: (_newvalue){
                            setState(() {
                              _value = _newvalue;

                            }

                            );
                          }
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0
                  ,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          children: [
                            SizedBox(width: 20,height: 10,),
                            Text(
                              "الرسائل".tr,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),]),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(
                                width: 5,
                              ),
                              Column(children: [
                                Text("نغمة الاشعارات".tr,
                                    style: Theme.of(context).textTheme.headline6),
                                Text("voyager".tr,
                                    style: TextStyle(color: Colors.grey)),
                              ],),

                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(children: [
                                Text("اهتزاز".tr,
                                    style: Theme.of(context).textTheme.headline6),
                                Text("التلقائي".tr,style: TextStyle(color: Colors.grey),)
                              ],),

                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),

                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              SizedBox(
                                width: 5,
                              ),

                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
