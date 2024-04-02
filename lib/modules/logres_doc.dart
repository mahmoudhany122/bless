import 'package:blessmate/modules/signupdoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login.dart';

class LogResDoc extends StatelessWidget {
  const LogResDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Image(
              image: AssetImage('assets/images/img_8.png'),
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/img_11.png'),
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "مرحبا بك في".tr,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "BLISSMATE",
                      style:TextStyle(
                        color: HexColor('00B4D8'),
                      ) ,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Center(
                    child: Text(
                      "أخبرنا عن مشاكلك، ونحن سوف نساعدك".tr,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor('00B4D8'),
                    shape: BoxShape.rectangle,
                  ),
                  child: TextButton(
                    child: Text(
                      "تسجيل الدخول".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen(),
                          ),
                        ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 50,
                  width: 350,
                  clipBehavior:Clip.hardEdge ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color:HexColor('00B4D8'),
                      width: 2,
                    ),
                  ),
                  child: TextButton(
                    child: Text(
                      "اشتراك".tr,
                      style: TextStyle(
                        color: HexColor('00B4D8'),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) =>SignUpDoc(),
                          ),
                        ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  ": تابع حسابتنا على وسائل التواصل الاجتماعى  ".tr,
                  style:Theme.of(context).textTheme.headline6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.facebook,
                        color: Colors.indigo,
                        size: 33,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Image(
                        image: AssetImage(
                            'assets/images/icons8-instagram-96.png'
                        ),
                        width: 28,
                        height: 35,

                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Image(
                        image: AssetImage(
                            'assets/images/icon.jpg'
                        ),
                        width: 40,
                        height: 35,

                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Image(
                        image: AssetImage(
                          'assets/images/icons8-twitter-96.png',
                        ),
                        width: 40,
                        height: 35,

                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
