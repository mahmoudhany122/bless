import 'package:blessmate/modules/dark.dart';
import 'package:blessmate/modules/logres.dart';
import 'package:blessmate/modules/notification.dart';
import 'package:flutter/material.dart';
import 'package:blessmate/modules/change_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart'
as hex; // aliasing the external HexColor class
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_after_signu.dart';
enum MyThemeMode {
  light,
  dark,
  third,
}
var myColor = hex.HexColor('00B4D8');

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen1> {

  bool _switch = false;

  String _selectedLanguage = 'ar';

  String _firstName = '';
  String _lastName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstName') ?? '';
      _lastName = prefs.getString('lastName') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  String extractUsername(String email) {
    // Split email based on '@' symbol
    List<String> parts = email.split('@');
    // Return the first part (username)
    return parts[0];
  }
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ValueNotifier<MyThemeMode>>(context);
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
                                        Container(
                                          width: 70,
                                          height: 70,

                                          child: Image(
                                            image: AssetImage("assets/images/img_12.png",),
                                            width: 70,height: 70,
                                          )
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                                Text(
                                                   "ليلي".tr,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold)),
                                                SizedBox(
                                                  width: 5,
                                                ),

                                            Text( extractUsername(_email),
                                                style: TextStyle(fontSize: 15,color: Colors.white)),
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
                                                        showDialog(
                                                            context: context,
                                                            builder: (context)=>AlertDialog(
                                                              actions: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    SizedBox(height: 10,),
                                                                    Center(
                                                                      child: Text("الوضع".tr,style: TextStyle(color: HexColor('00B4D8')),),),
                                                                    SizedBox(height: 5,),
                                                                    Divider(height: 1,),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    RadioListTile<MyThemeMode>(
                                                                      title:  Text('فاتح'.tr,
                                                                        style: TextStyle(color: Colors.black),
                                                                      ),
                                                                      activeColor: HexColor('00B4D8'),
                                                                      value:MyThemeMode .light,
                                                                      groupValue: themeMode.value,
                                                                      onChanged: (value) {
                                                                        themeMode.value = value!;

                                                                      },
                                                                    ),
                                                                    RadioListTile<MyThemeMode>(
                                                                      title:  Text('غامق'.tr,
                                                                        style: TextStyle(color:Colors.black),
                                                                      ),
                                                                      activeColor: HexColor('00B4D8'),
                                                                      value: MyThemeMode .dark,
                                                                      groupValue: themeMode.value,
                                                                      onChanged: (value) {
                                                                        themeMode.value = value!;
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],

                                                            )
                                                        );
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

                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context)=>AlertDialog(
                                                  actions: [

                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text( "مشاركة عبر".tr, style: Theme.of(context).textTheme.headline6,),
                                                            SizedBox(width: 5,),
                                                            Image( width: 20,
                                                                height: 20,
                                                                image: AssetImage("assets/images/img_39.png"))
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                TextButton (
                                                                    onPressed: (){},
                                                                    child:Image( width: 42,
                                                                        height: 42,
                                                                        image: AssetImage("assets/images/img_43.png"))
                                                                ),
                                                                Text("نسخ الرابط".tr,style: TextStyle(color: myColor,fontWeight: FontWeight.bold ,fontSize: 10,))
                                                              ],
                                                            ), Column(
                                                              children: [
                                                                TextButton (
                                                                    onPressed: (){},
                                                                    child:Image( width: 42,
                                                                        height: 42,
                                                                        image: AssetImage("assets/images/img_42.png"))
                                                                ),
                                                                Text("انستجرام".tr,style: TextStyle(color: myColor,fontWeight: FontWeight.bold ,fontSize: 10,))
                                                              ],
                                                            ), Column(
                                                              children: [
                                                                TextButton (
                                                                    onPressed: (){},
                                                                    child:Image( width: 42,
                                                                        height: 42,
                                                                        image: AssetImage("assets/images/img_41.png"))
                                                                ),
                                                                Text("فيسبوك".tr,style: TextStyle(color: myColor,fontWeight: FontWeight.bold ,fontSize: 10,))
                                                              ],
                                                            ), Column(
                                                              children: [
                                                                TextButton (
                                                                    onPressed: (){},
                                                                    child:Image( width: 42,
                                                                        height: 42,
                                                                        image: AssetImage("assets/images/img_40.png"))
                                                                ),
                                                                Text("واتساب".tr,style: TextStyle(color: myColor,fontWeight: FontWeight.bold ,fontSize: 10,))
                                                              ],
                                                            ),
                                                         
                                                        ],)
                                                       

                                                     ]
                                                  , title:Column(
                                                children: [
                                                  Center(
                                                    child: Text ("ادعو أصدقاء".tr,style: TextStyle(color: myColor,fontWeight: FontWeight.bold ,fontSize: 28),

                                                    ),

                                                  ),
                                                  SizedBox(height: 5,),
                                                  Divider(height: 1,)
                                                ],
                                              )


                                              )  );},
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


                                                ElevatedButton(onPressed: (){ Navigator.pushAndRemoveUntil(
                                                    context,MaterialPageRoute(builder: (context) => LogRes(),),((route) => false));},
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
                                                     onPressed: (){  Navigator.pushAndRemoveUntil(
                                                                                     context,MaterialPageRoute(builder: (context) => ProfileScreen1(),),((route) => false));},
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
                                              content: Text( "هل أنت متأكد أنك تريد تسجيل الخروج ".tr, style: Theme.of(context).textTheme.headline6,)
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


