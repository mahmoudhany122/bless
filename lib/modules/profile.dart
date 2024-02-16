import 'package:blessmate/modules/change_password.dart';
import 'package:blessmate/modules/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart'
    as hex; // aliasing the external HexColor class
import 'add_after_signu.dart';

var myColor = hex.HexColor('00B4D8');

 class ProfileScreen extends StatelessWidget {
  String _selectedLanguage = 'ar';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "الملف الشخصي",
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
                            Text("ليلى",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold)),

                            Text("عرض و تحرير ملفك الشخصي",
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
         "الإعدادات العامة  ",
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),],),
              Container(
                width: double.infinity,
                height: 326,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                       vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
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
                              Text("تحرير الملف الشخصي",
                                  style: TextStyle(fontSize: 16,color: Colors.black)),
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
                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
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
                                  style: Theme.of(context).textTheme.headline6),
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
                                  {
                                    _selectedLanguage = value!;
                                  };
                                  Get.updateLocale(Locale(_selectedLanguage));
                                },),

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
                              Text("تغيير كلمة المرور",
                                  style: TextStyle(fontSize: 16,color: Colors.black)),
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

            ]
          ),
        ),
      ),
            ]
          )
      )]
    )))
    )));
  }



  
}
