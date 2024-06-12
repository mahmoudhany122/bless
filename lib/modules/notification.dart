import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
var myColor = HexColor('00B4D8');

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification()async{
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('assets/images/img_1.png');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse)async{}
    );
  }
  notificationDetails(){
    return NotificationDetails(
      android: AndroidNotificationDetails("channelId",'channelName',
      importance: Importance.max)
    );
  }

  Future showNotification(
  {int id =0, String? title, String?body, String? payLoad})async{
    return flutterLocalNotificationsPlugin.show(id, title, body,await notificationDetails());
  }

  Future<DateTime> fetchAppointmentDate() async {
    final response =
    await http.get(Uri.https('blessmate.onrender.com', '/Patient/GetTherapistes'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String appointmentDateString = data['appointment_date'];
      final DateTime appointmentDate = DateTime.parse(appointmentDateString);
      return appointmentDate;
    } else {
      throw Exception('Failed to load appointment date');
    }
  }
  @override
  Widget build(BuildContext context) {
    bool _value = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("الإشعارات".tr,style:  Theme.of(context).textTheme.bodyText2,),
        centerTitle: true,
      ),
      body:  ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child:  Text("اليوم-20مايو2024".tr,style: Theme.of(context).textTheme.bodyText1,),
              ),
              Container(
                  height: 105,
                  width:MediaQuery.of(context).size.width,
                  color:HexColor('D1F1F8'),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Container(
                            margin: EdgeInsets.only(right: 10,bottom: 30),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color:HexColor("D9D9D9"),
                                      blurRadius: 4,
                                      offset: Offset(1, 1)
                                  ),

                                ]
                            ),
                            child: Icon(Icons.calendar_month_outlined,color: HexColor('00B4D8'), size: 35),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 2) ,
                            width: 300,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: (){},
                                  child:Text(
                                    "لديك موعد مع د.احمد اسماعيل اليوم في الساعة7:00 م".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                                ),
                                Text("الآن".tr,style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,)
                                ,
                              ],
                            ) ,
                          ),
                        ],
                      ),

                      Divider(color: Colors.grey,height: 1,),
                    ],
                  )

              ), Container(
                  height: 101,
                  width: double.infinity,
                  color:HexColor('D1F1F8'),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,bottom: 30),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color:HexColor("D9D9D9"),
                                      blurRadius: 4,
                                      offset: Offset(1, 1)
                                  ),

                                ]
                            ),
                            child: Icon(Icons.calendar_month_outlined,color: HexColor('00B4D8'), size: 35),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 2) ,
                            width: 300,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(onPressed: (){}, child: Text("لديك موعد مع د.احمد اسماعيل اليوم في الساعة7:00 م".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),), ),
                                Text("منذ 25 دقيقة".tr,style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),
                              ],
                            ) ,
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,height: 1,),
                    ],
                  )

              ), Container(
                  height: 101,
                  width: double.infinity,
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,bottom: 30),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color:HexColor("D9D9D9"),
                                      blurRadius: 4,
                                      offset: Offset(1, 1)
                                  ),

                                ]
                            ),
                            child: Icon(Icons.calendar_month_outlined,color: HexColor('00B4D8'), size: 35),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 2) ,
                            width: 300,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(onPressed: (){}, child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("لديك موعد مع د.احمد اسماعيل اليوم في الساعة7:00 م".tr,style:Theme.of(context).textTheme.headline5 ,),

                                  ],
                                ),
                                ),
                                Text("منذ 2 ساعات".tr,style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 )) ,
                              ],
                            ) ,
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,height: 1,),
                    ],
                  )

              ),
              Container(
                margin: EdgeInsets.all(10),
                child:  Text("19أبريل2024".tr,style: Theme.of(context).textTheme.bodyText1,),
              ),
              Container(
                  height: 101,
                  width: double.infinity,
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,bottom: 30),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color:HexColor("D9D9D9"),
                                      blurRadius: 4,
                                      offset: Offset(1, 1)
                                  ),

                                ]
                            ),
                            child: Icon(Icons.calendar_month_outlined,color: HexColor('00B4D8'), size: 35),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 2) ,
                            width: 300,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(onPressed: (){}, child:Text("لديك موعد مع د.احمد اسماعيل اليوم في الساعة7:00 م".tr,style: Theme.of(context).textTheme.headline5,), ),
                                Text("أمس.7:58 صباحآ".tr,style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 )),
                              ],
                            ) ,
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,height: 1,),
                    ],
                  )

              ), Container(
                  height: 101,
                  width: double.infinity,
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,bottom: 30),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color:HexColor("D9D9D9"),
                                      blurRadius: 4,
                                      offset: Offset(1, 1)
                                  ),

                                ]
                            ),
                            child: Icon(Icons.calendar_month_outlined,color: HexColor('00B4D8'), size: 35),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 2) ,
                            width: 300,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(onPressed: (){}, child: Text("لديك موعد مع د.احمد اسماعيل اليوم في الساعة5:00 م".tr,style: Theme.of(context).textTheme.headline5,), ),
                                Text("أمس.9:58 صباحآ".tr,style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),
                              ],
                            ) ,
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,height: 1,),
                    ],
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
