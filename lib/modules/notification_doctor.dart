import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationDoctorScreen extends StatefulWidget {
  const NotificationDoctorScreen({super.key});

  @override
  State<NotificationDoctorScreen> createState() => _NotificationDoctorScreenState();
}

class _NotificationDoctorScreenState extends State<NotificationDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإشعارات",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child:  Text("اليوم-20مايو2024",style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.w500,),),
              ),
              Container(
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
                           padding: EdgeInsets.only(left: 10,right: 10,top: 8) ,
                           width: 325,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               TextButton(
                                   onPressed: (){},
                                   child:Text(
                                 "لديك موعد مع سارة ابراهيم الساعه 08:00 مساء اليوم.",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                               ),
                               Text("الآن",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,)
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
                           child: Icon(Icons.person_outline_outlined,color: HexColor('00B4D8'), size: 35),
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 10,right: 10,top: 8) ,
                           width: 340,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               TextButton(onPressed: (){}, child: Text("أكمل ملفك الشخصي لتكون مستشارآ صحيآ أفضل. ملف كامل",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),), ),
                               Text("منذ 25 دقيقة",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),
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
                           child: Icon(Icons.credit_card,color: HexColor('00B4D8'), size: 35),
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 10,right: 10,top: 2) ,
                           width: 340,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               TextButton(onPressed: (){}, child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("أضف حسابآ مصرفيآ لسحب دخلك.",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                                  Text("أضف الآن >",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16,fontWeight: FontWeight.bold) ) ,

    ],
                                ),
                                 ),
                               Text("منذ 2 ساعات",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ,fontWeight: FontWeight.bold)) ,
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
                child:  Text("19أبريل2024",style: TextStyle(fontSize: 20,color: Colors.grey.shade600,fontWeight: FontWeight.w500,),),
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
                           padding: EdgeInsets.only(left: 10,right: 10,top: 8) ,
                           width: 340,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               TextButton(onPressed: (){}, child:Text("لديك موعد مع ليلى باسم الساعة05:00 مساء اليوم.",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),), ),
                               Text("أمس.10:58 صباحآ",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),
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
                           child: Icon(Icons.call_outlined,color: HexColor('00B4D8'), size: 35),
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 10,right: 10,top: 8) ,
                           width: 340,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               TextButton(onPressed: (){}, child: Text("لديك طلب مكالمة صوتية من علي فى الساعة08:20 صباحآ اليوم.",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),), ),
                               Text("أمس.7:58 صباحآ",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),
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
                           padding: EdgeInsets.only(left: 10,right: 10,top: 8) ,
                           width: 340,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               TextButton(onPressed: (){}, child: Text("لديك موعد مع كريم عزت الساعة05:00 مساء اليوم.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),), ),
                               Text("أمس.الساعة2:00 صباحآ",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),

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
                           child: Icon(Icons.call_outlined,color: HexColor('00B4D8'), size: 35),
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 10,right: 10,top: 8) ,
                           width: 340,
                           height: 100,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [TextButton(onPressed: (){}, child: Text("لديك طلب مكالمة صوتية من وليد عامر في الساعة 08:20 صباحآاليوم.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),), ),
                               Text("أمس.الساعة08:20 صباحآ",style:TextStyle(color: HexColor('00B4D8'),fontSize: 16 ) ,),

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
