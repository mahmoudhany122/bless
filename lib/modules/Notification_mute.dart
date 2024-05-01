import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotificationMute extends StatefulWidget {
  const NotificationMute({super.key});

  @override
  State<NotificationMute> createState() => _NotificationMuteState();
}

class _NotificationMuteState extends State<NotificationMute> {
  bool isMuted = false;

  void toggleMute(bool value) {
    setState(() {
      isMuted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإشعارات",style:  Theme.of(context).textTheme.bodyText2),
        centerTitle: true,
      ),
      body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              padding: EdgeInsets.only(left: 15,right: 15),
              width:double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.start,
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: 15,),
                       Text('نغمه المحادثات', style: Theme.of(context).textTheme.headlineLarge),
                       Text('تشغيل الأصوات للرسائل الواردة والصادرة', style: Theme.of(context).textTheme.headline6)
                     ],
                   ),
                   Spacer(),

                     Switch(
                       value: isMuted,
                       onChanged: toggleMute,
                       activeTrackColor: HexColor('00B4D8') ,
                       inactiveTrackColor: Colors.white,
                       inactiveThumbColor: HexColor('00B4D8'),
                     ),

                 ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              padding: EdgeInsets.only(left: 15,right: 15),
              width:double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color:Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: 15,),
                       Text('الرسائل', style: Theme.of(context).textTheme.headlineLarge),
                       SizedBox(height:15,),
                       Row(
                         children: [
                           TextButton(
                             onPressed: (){},
                             child: Text ('نغمة الاشعارات', style: Theme.of(context).textTheme.headlineLarge),
                           ),
                           Spacer(),
                           Icon(
                             Icons.arrow_forward_ios,
                             color: Colors.black,
                           ),
                         ],
                       ),
                       SizedBox(height: 5,),
                       Divider(height: 1,)  ,
                       SizedBox(height: 15,),
                       Row(
                         children: [
                           TextButton(
                             onPressed: (){},
                             child: Text ('اهتزاز', style: Theme.of(context).textTheme.headlineLarge),
                           ),
                           Spacer(),
                           Icon(
                             Icons.arrow_forward_ios,
                             color: Colors.black,
                           ),
                         ],
                       ),
                       SizedBox(height: 5,),
                       Divider(height: 1,)
                     ],
                   ),



            ),
          ],
        ),

    );
  }
}
