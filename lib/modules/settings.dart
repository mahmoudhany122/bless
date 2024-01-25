import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'dark.dart';
import 'logres.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "إعدادات",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.right,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_back_ios_new),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Linda",
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            height: 10,
                          ),
                          Text("mh6263653@gmail.com",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image(
                        image: AssetImage(
                          "assets/images/img_12.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "عام  ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              Spacer(),
                              Text("إشعارات",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.notifications_none,
                                color: HexColor('00B4D8'),
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              Spacer(),
                              Text("اللغه",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.language_outlined,
                                color: HexColor('00B4D8'),
                              ),
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
                                  builder: (context) =>
                                      BrightnessSelectionScreen(),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              Spacer(),
                              Text("الثيم",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.color_lens_outlined,
                                color: HexColor('00B4D8'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "خاص  ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              Spacer(),
                              Text("سياسة الخصوصية",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.help_center_outlined,
                                color: HexColor('00B4D8'),
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              Spacer(),
                              Text("الدعم",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.support_agent_outlined,
                                color: HexColor('00B4D8'),
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_back_ios_new),
                              Spacer(),
                              Text("البنود و الظروف",
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit_attributes_outlined,
                                color: HexColor('00B4D8'),
                              ),
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
                    color: HexColor('00B4D8'),
                  ),
                  child: MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "تسجيل الخروج",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        showCancelBtn: true,
                        title: "تسجيل خروج",
                        text: "هل أنت متأكد أنك تريد تسجيل الخروج ",
                        confirmBtnText: 'نعم ',
                        cancelBtnText: 'الغاء',
                        backgroundColor: Colors.white,
                        cancelBtnTextStyle:
                            Theme.of(context).textTheme.bodyText1,
                        confirmBtnTextStyle: Theme.of(context).textTheme.button,
                        confirmBtnColor: HexColor('00B4D8'),
                        headerBackgroundColor: Colors.black,
                        animType: QuickAlertAnimType.slideInRight,
                        onConfirmBtnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogRes(),
                              ));
                        },
                        onCancelBtnTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Settings(),
                              ));
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
