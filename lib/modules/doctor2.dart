import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeDoctor2 extends StatefulWidget {
  const HomeDoctor2({super.key});

  @override
  State<HomeDoctor2> createState() => _HomeDoctor2State();
}

class _HomeDoctor2State extends State<HomeDoctor2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("جدول المواعيد",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true, ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Text("فبراير",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: HexColor("00B4D8",) ),),
                    ],
                  ),
                  Image(image: AssetImage("assets/images/img_34.png")),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                    child:  Text("المواعيد القادمة",style: TextStyle(fontSize: 20,color:HexColor("00B4D8"),fontWeight: FontWeight.bold,)),
                  ),
                  TextButton(onPressed: (){},
                      child:
                      Container(
                        padding:  EdgeInsets.only(right: 10,left: 10),
                        height: 80,
                        width: 400,
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
                        child: Row(
                          children: [
                            Container(
                              height:60,
                              width: 60,
                              margin: EdgeInsets.only(right: 10,left: 10,top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),

                              ),
                              child:
                              Image(
                                image: AssetImage(
                                  "assets/images/img_29.png",
                                ),),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Text("ماريا كرم",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                    SizedBox(width: 2,),
                                    Text("غدا عند 4:00 م",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ),  TextButton(onPressed: (){},
                      child:
                      Container(
                        padding:  EdgeInsets.only(right: 10,left: 10),
                        height: 80,
                        width: 400,
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
                        child: Row(
                          children: [
                            Container(
                              height:60,
                              width: 60,
                              margin: EdgeInsets.only(right: 10,left: 10,top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),

                              ),
                              child:
                              Image(
                                image: AssetImage(
                                  "assets/images/img_30.png",
                                ),),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Text("زياد الشرقاوي",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                    SizedBox(width: 2,),
                                    Text("غدا عند 5:00 م",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ),  TextButton(onPressed: (){},
                      child:
                      Container(
                        padding:  EdgeInsets.only(right: 10,left: 10),
                        height: 80,
                        width: 400,
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
                        child: Row(
                          children: [
                            Container(
                              height:60,
                              width: 60,
                              margin: EdgeInsets.only(right: 10,left: 10,top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),

                              ),
                              child:
                              Image(
                                image: AssetImage(
                                  "assets/images/img_31.png",
                                ),),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),

                                Text("جينا احمد",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                    SizedBox(width: 2,),
                                    Text("غدا عند 5:00 م",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                ],
              )
          )
      
        ],
      ),
    );
  }
}
