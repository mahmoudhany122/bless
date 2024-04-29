import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeDoctor3 extends StatefulWidget {
  const HomeDoctor3({super.key});

  @override
  State<HomeDoctor3> createState() => _HomeDoctor3State();
}

class _HomeDoctor3State extends State<HomeDoctor3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("إدارة المرضى".tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true, ),
      body: ListView(
        children: [
          Column(
            children: [
              TextButton(onPressed: (){},
                  child:
                  Container(
                    padding:  EdgeInsets.only(right: 10,left: 10),
                    height: 95,
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
                          height:70,
                          width: 70,
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
                            Text("جينا احمد".tr,style: TextStyle(fontSize: 18,color: HexColor("00B4D8",),fontWeight: FontWeight.bold),),

                                Text("أنثى   .24 سنة ".tr,style: TextStyle(fontSize: 15,color: Colors.black),),
                            Row(
                              children: [
                                Icon(Icons.call_outlined,color: HexColor("00B4D8",),size: 18,),
                                SizedBox(width: 5,),
                                Text("201-460-2450",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
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
                    height: 95,
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
                          height:70,
                          width: 70,
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
                            Text("بسام نور".tr,style: TextStyle(fontSize: 18,color: HexColor("00B4D8",),fontWeight: FontWeight.bold),),
                                Text(" ذكر   .28 سنة".tr,style: TextStyle(fontSize: 15,color: Colors.black),),

                            Row(
                              children: [
                                Icon(Icons.call_outlined,color: HexColor("00B4D8",),size: 18,),
                                SizedBox(width: 5,),
                                Text("745-221-2921",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
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
                    height: 95,
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
                          height:70,
                          width: 70,
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
                            Text("لارا علاء".tr,style: TextStyle(fontSize: 18,color: HexColor("00B4D8",),fontWeight: FontWeight.bold),),
                                Text("أنثى   .21 سنة ".tr,style: TextStyle(fontSize: 15,color: Colors.black),),
                            Row(
                              children: [
                                Icon(Icons.call_outlined,color: HexColor("00B4D8",),size:18,),
                                SizedBox(width: 5,),
                                Text("280-388-2736",style: TextStyle(fontSize: 15,color: Colors.black),),
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
                    height: 95,
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
                          height:70,
                          width: 70,
                          margin: EdgeInsets.only(right: 10,left: 10,top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),

                          ),
                          child:
                          Image(
                            image: AssetImage(
                              "assets/images/img_35.png",
                            ),),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("سيليا سمير".tr,style: TextStyle(fontSize: 18,color: HexColor("00B4D8",),fontWeight: FontWeight.bold),),
                                Text("أنثى   .30 سنة ".tr,style: TextStyle(fontSize: 15,color: Colors.black),),
                            Row(
                              children: [
                                Icon(Icons.call_outlined,color: HexColor("00B4D8",),size:18,),
                                SizedBox(width: 5,),
                                Text("802-401-2509",style: TextStyle(fontSize: 15,color: Colors.black),),
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
                    height: 95,
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
                          height:70,
                          width: 70,
                          margin: EdgeInsets.only(right: 10,left: 10,top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),

                          ),
                          child:
                          Image(
                            image: AssetImage(
                              "assets/images/img_36.png",
                            ),),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("عمر عادل".tr,style: TextStyle(fontSize: 18,color: HexColor("00B4D8",),fontWeight: FontWeight.bold),),
                                Text("ذكر   .24 سنة ".tr,style: TextStyle(fontSize: 15,color: Colors.black),),
                            Row(
                              children: [
                                Icon(Icons.call_outlined,color: HexColor("00B4D8",),size:18,),
                                SizedBox(width: 5,),
                                Text("915-680-4490",style: TextStyle(fontSize: 15,color: Colors.black),),
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
                    height: 95,
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
                          height:70,
                          width: 70,
                          margin: EdgeInsets.only(right: 10,left: 10,top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),

                          ),
                          child:
                          Image(
                            image: AssetImage(
                              "assets/images/img_37.png",
                            ),),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("جورج بيتر".tr,style: TextStyle(fontSize: 18,color: HexColor("00B4D8",),fontWeight: FontWeight.bold),),
                                Text("ذكر   .26 سنة ".tr,style: TextStyle(fontSize: 15,color: Colors.black),),
                            Row(
                              children: [
                                Icon(Icons.call_outlined,color: HexColor("00B4D8",),size:18,),
                                SizedBox(width: 5,),
                                Text("955-558-0311",style: TextStyle(fontSize: 15,color: Colors.black),),
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
