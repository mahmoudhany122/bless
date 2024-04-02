import 'package:blessmate/modules/logres.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'logres_doc.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  late String? pickedImagePath = null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    pickedImagePath = pickedFile.path;
                  });
                }
              },
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                    shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:Colors.black,
                      width: 3,
                    ),
                ),
                child: Center(
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    size: 60,


                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (pickedImagePath != null)
              Image.file(
                // Display the picked image
                File(pickedImagePath!),
                width: 100,
                height: 100,
              ),
            SizedBox(
                height: 20
            ),
            Text(
                "قم برفع ملف به صورة للبطاقة الشخصية و ما يثبت أنك معالج نفسي يمارس المهنة",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
                height: 40
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(17),
                color: HexColor('00B4D8'),
              ),
              child: MaterialButton(
                onPressed: () {
                  // Add your logic to save the picked image
                  if (pickedImagePath != null) {
                    print('Image saved: $pickedImagePath');
                    // Add your save logic here
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogResDoc(),));
                },
                child: const Text(
                  "اشتراك",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
