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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child:  Text("اليوم-20 مايو 2024".tr,style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.w500,)),
              ),
                  TextButton(onPressed: (){},
                   child:
                    Container(
                    padding:  EdgeInsets.only(right: 10,left: 10),
                       height: 90,
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
                            Row(
                              children: [
                                Text("رسالة. ".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                                Text("مكتمل".tr,style: TextStyle(fontSize: 12,color: HexColor("3FD198"),fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Text("ماريا كرم".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                SizedBox(width: 2,),
                                Text("تم الرد في الساعة 4:00 مساء".tr,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
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
                       height: 90,
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
                            Row(
                              children: [
                                Text("ميعاد. ".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                                Text("مكتمل".tr,style: TextStyle(fontSize: 12,color: HexColor("3FD198"),fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Text("زياد الشرقاوي".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                SizedBox(width: 2,),
                                Text("4:00 مساء - 5:00 مساء".tr,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    )
                  ),
              TextButton(onPressed: (){},
                   child:
                    Container(
                    padding:  EdgeInsets.only(right: 10,left: 10),
                       height: 90,
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
                            Row(
                              children: [
                                Text("ميعاد. ".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                                Text("تم الإلغاء بواسطة المريض".tr,style: TextStyle(fontSize: 12,color: HexColor("FF5785"),fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Text("بسنت احمد".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                SizedBox(width: 2,),
                                Text("7:00 مساء - 8:00 مساء".tr,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    )
                  ),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child:  Text("19 أبريل 2024".tr,style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.w500,)),
              ),
              TextButton(onPressed: (){},
                  child:
                  Container(
                    padding:  EdgeInsets.only(right: 10,left: 10),
                    height: 90,
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
                              "assets/images/img_32.png",
                            ),),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text("رسالة. ".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                                Text("مكتمل".tr,style: TextStyle(fontSize: 12,color: HexColor("3FD198"),fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Text("لارا علاء".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                SizedBox(width: 2,),
                                Text("3:00 مساء - 4:00 مساء".tr,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
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
                    height: 90,
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
                              "assets/images/img_33.png",
                            ),),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text("ميعاد. ".tr,style: TextStyle(fontSize: 12,color: Colors.black),),
                                Text("مكتمل".tr,style: TextStyle(fontSize: 12,color: HexColor("3FD198"),fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Text("نور بسام".tr,style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Icon(Icons.access_time,color: HexColor("00B4D8",),size: 12,),
                                SizedBox(width: 2,),
                                Text("4:00 مساء - 5:00 مساء".tr,style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
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
        ],
      ),
    );
  }
}
