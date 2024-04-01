import 'package:blessmate/modules/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'id.dart';
import 'logres.dart';

class SignInDoc extends StatelessWidget {
  const SignInDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/img_7.png'),
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "اختر فئتك",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor('00B4D8'),
              shape: BoxShape.rectangle,
            ),
            child: TextButton(
              child: Text(
                "معالج نفسي",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              onPressed: () =>
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyPage(),
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
              borderRadius: BorderRadius.circular(10),
              color:Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(
                color:HexColor('00B4D8'),
                width: 2,
              ),
            ),
            child: TextButton(
              child: Text(
                "مريض",
                style: TextStyle(
                  color: HexColor('00B4D8'),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              onPressed: () =>
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (context) => LogRes(),
                    ),
                  ),
            ),
          ),

        ],
      ),

    );
  }
}
