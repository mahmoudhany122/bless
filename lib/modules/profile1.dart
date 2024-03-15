import 'package:blessmate/modules/dark.dart';
import 'package:blessmate/modules/logres.dart';
import 'package:blessmate/modules/notification.dart';
import 'package:flutter/material.dart';
import 'package:blessmate/modules/change_password.dart';
import 'package:blessmate/modules/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart'
as hex; // aliasing the external HexColor class
import 'add_after_signu.dart';

var myColor = hex.HexColor('00B4D8');

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen1> {

  bool _switch = false;

  String _selectedLanguage = 'ar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "الملف الشخصي".tr,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.right,
            ),
          ),
          elevation: 2,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:Container(
                    width: MediaQuery.of(context).size.width,
                    child: Directionality(
                        textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                        child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: myColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                            "assets/images/img_12.png",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("ليلى".tr,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold)),

                                            Text("عرض و تحرير ملفك الشخصي".tr,
                                                style: TextStyle(fontSize: 16,color: Colors.white)),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios,color: Colors.white,),

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 5,),
                                            Text(
                                              "الإعدادات العامة  ".tr,
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                                            ),],),
                                        Container(
                                          width: double.infinity,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(15),


                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => AddInSignUp(),
                                                            ));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            Icons.edit_outlined,
                                                            color: myColor,
                                                          ),
                                                          SizedBox(width: 5,),
                                                          Text("تحرير الملف الشخصي".tr,style:
                                                              Theme.of(context).textTheme.headline6),
                                                          Spacer(),
                                                          Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => NotificationScreen(),
                                                            ));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            Icons.notifications_none,
                                                            color: myColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("إشعارات".tr,
                                                              style: Theme.of(context).textTheme.headline6),

                                                          Spacer(),
                                                          Icon(Icons.arrow_forward_ios,color: Colors.black,),

                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(0),
                                                    child: TextButton(
                                                      onPressed: () {

                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            Icons.language_outlined,
                                                            color: myColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("اللغه".tr,
                                                              style:  Theme.of(context).textTheme.headline6),
                                                          Spacer(),

                                                          DropdownButton(
                                                            items: [
                                                              DropdownMenuItem(
                                                                  child: Text("اللغه الانجليزيه".tr,style: TextStyle(color:myColor, ),),
                                                                  value : 'en'),
                                                              DropdownMenuItem(
                                                                  child: Text("اللغه العربيه".tr,style: TextStyle(color:myColor, ),),
                                                                  value : 'ar'),
                                                            ],
                                                            value: _selectedLanguage,
                                                            onChanged: (value){
                                                            setState(() {
                                                              _selectedLanguage = value!;
                                                            });

                                                              Get.updateLocale(Locale(_selectedLanguage));
                                                            },),

                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => ChangePasswordScreen(),
                                                            ));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            Icons.lock_outline,
                                                            color: myColor,
                                                          ),
                                                          SizedBox(width: 5,),
                                                          Text("تغيير كلمة المرور".tr,
                                                              style:  Theme.of(context).textTheme.headline6),
                                                          Spacer(),
                                                          Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BrightnessSelectionScreen(),
                                                            ));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            Icons.dark_mode_outlined,
                                                            color: myColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("الوضع الداكن".tr,
                                                              style: Theme.of(context).textTheme.headline6),

                                                          Spacer(),
                                                          Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ]
                                            ),
                                          ),
                                        ),
                                      ]
                                  )
                              ),

                              Row(
                                  children: [
                                    Text(
                                      " إعدادات الحساب ".tr,
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                                    ),]),
                              SizedBox(height: 5,),
                              Container(
                                width: double.infinity,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [


                                              Icon(
                                                Icons.payment_outlined,
                                                color: myColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("طريقه الدفع".tr,
                                                  style: Theme.of(context).textTheme.headline6),
                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                            ],
                                          ),
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.support_agent_outlined,
                                                color: myColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("مركز الساعده".tr,
                                                  style:  Theme.of(context).textTheme.headline6),
                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                            ],
                                          ),
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [  Icon(
                                              Icons.person_add_alt_1_outlined,
                                              color: myColor,
                                            ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("دعوة الأصدقاء".tr,
                                                  style:  Theme.of(context).textTheme.headline6),
                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios,color:Colors.black ,),
                                            ],
                                          ),
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.help_outline,
                                                color: myColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("سياسة الخصوصية".tr,
                                                  style:  Theme.of(context).textTheme.headline6),
                                              Spacer(),
                                              Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.help_center_outlined,
                                                color: myColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("الشروط و الأحكام".tr,
                                                  style:  Theme.of(context).textTheme.headline6),
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
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(17),
                                    color: myColor,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: myColor
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [


                                        Text(
                                          "تسجيل الخروج".tr,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context)=>AlertDialog(
                                              actions: [


                                                ElevatedButton(onPressed: (){ Navigator.push(
                                                    context,MaterialPageRoute(builder: (context) => LogRes(),));},
                                                  child: Text ("نعم. قم بتسجيل الخروج".tr,style: TextStyle(color:Colors.white,fontSize: 14),),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: myColor
                                                  ),

                                                ),
                                                Container(
                                                  width : 80,
                                                  height : 40,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: myColor),
                                                      borderRadius: BorderRadius.circular(50)
                                                    )
                                                  ,

                                                  child:
                                                    TextButton (
                                                     onPressed: (){  Navigator.push(
                                                                                     context,MaterialPageRoute(builder: (context) => ProfileScreen1(),));},
                                                         child: Text(
                                                        "الغاء".tr,style: TextStyle(fontSize:16,color: Colors.black),

                                                    ),
                                                )

                                                ) ]
                                              , title:
                                          Center(
                                            child: Text ("تسجيل خروج".tr,style: TextStyle(color: myColor,fontWeight: FontWeight.bold ,fontSize: 28),

                                            ),

                                          ),
                                              content: Text( "هل أنت متأكد أنك تريد تسجيل الخروج ".tr,  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                          )  );
                                    },
                                  ),
                                ),
                              ),
                            ],
                        ),
                    ),
                ),
            ) ));
  }




}


