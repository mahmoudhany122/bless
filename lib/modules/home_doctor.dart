import 'package:blessmate/modules/doctor1.dart';
import 'package:blessmate/modules/doctor2.dart';
import 'package:blessmate/modules/doctor3.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'chatitem.dart';
import 'doctor_patient_chat.dart';

class HomeDoctorScreen extends StatefulWidget {
  final int therapistId;

  const HomeDoctorScreen({super.key, required this.therapistId});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,),
              TextButton(
                  onPressed: (){},
                  child:
                  Container(
                    padding:  EdgeInsets.only(right: 10,left: 10),
                      height: 110,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border:Border.all(color: HexColor("E4E4E7"),
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("E4E4E7"),
                                blurRadius: 5,
                                offset: Offset(1, 1)
                            ),
                          ]
                      ),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10,right: 20,top: 10,bottom: 10),

                            ),
                            Text("استشارات اليوم",style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("تم الإنتهاء من 5 من 10",style: TextStyle(color: Colors.grey,fontSize: 14),)
                          ],
                        ),
                        Spacer(),
                        Image(
                          image: AssetImage(
                              "assets/images/img_28.png",),
                          width: 85,height: 85,
                        )
                      ],
                    ),)
               ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDoctor2(therapistId: widget.therapistId),
                        ));
                  },
                      child:Container(
                        padding: EdgeInsets.only(top: 30,bottom: 10,right: 10,left: 10),
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border:Border.all(color: HexColor("E4E4E7"),
                              width: 2),
                        ),
                        child:
                        Column(
                          children: [
                            Image(
                              width: 81,
                              height: 81,
                              image: AssetImage("assets/images/img_27.png"),
                            ),
                            SizedBox(height: 10,),
                            Text("جدول المواعيد",style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 10,),
                  TextButton(
                      onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDoctor1(),
                        ));
                  },
                      child:Container(
                        padding: EdgeInsets.only(top: 30,bottom: 10,right: 10,left: 10),
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border:Border.all(color: HexColor("E4E4E7"),
                              width: 2),
                        ),
                        child:
                        Column(
                          children: [
                            Image(
                              width: 81,
                              height: 81,
                              image: AssetImage("assets/images/img_26.png"),
                            ),
                            SizedBox(height: 10,),
                            Text("تاريخ الاستشارات",style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )),
                ],
              )  ,
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeDoctor3(),
                        ));
                  },
                      child:Container(
                        padding: EdgeInsets.only(top: 30,bottom: 10,right: 10,left: 10),
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border:Border.all(color: HexColor("E4E4E7"),
                              width: 2),
                        ),
                        child:
                        Column(
                          children: [
                            Image(
                              width: 81,
                              height: 81,
                              image: AssetImage("assets/images/img_25.png"),
                            ),
                            SizedBox(height: 10,),
                            Text("إدارة المرضي",style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 10,),
                  TextButton(
                      onPressed: (){

                    Navigator.push(context,MaterialPageRoute(builder: (context) =>SCREENMESSENGER(),));
                  },
                      child:Container(
                        padding: EdgeInsets.only(top: 30,bottom: 10,right: 10,left: 10),
                       width: 160,
                       height: 160,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(18),
                         border:Border.all(color: HexColor("E4E4E7"),
                         width: 2),
                       ),
                       child:
                      Column(
                       children: [
                         Image(
                           width: 81,
                           height: 81,
                           image: AssetImage("assets/images/img_24.png"),
                         ),
                         SizedBox(height: 10,),
                         Text("استشارات مجانية",style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      )
                     ),
                ],
              )
            ],
          )
        ],
      )
      ,
    );
  }
}
