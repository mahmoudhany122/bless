import 'dart:io';
import 'package:blessmate/modules/tap_bar_doctor.dart';
import 'package:flutter/material.dart';
import 'package:blessmate/modules/doctor_details_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadImagePage extends StatefulWidget {
  final int therapistId; // تحديد المتغير لاستقبال معرّف المعالج النفسي

  const UploadImagePage({Key? key, required this.therapistId}) : super(key: key);

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  String? pickedImagePath;

  Future<void> _uploadImage() async {
    if (pickedImagePath == null) {
      return;
    }

    final url = Uri.parse('https://blessmate.onrender.com/Therapist/TherapistCertificate?id=${widget.therapistId}'); // استخدام معرّف المعالج النفسي

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('Certificate', pickedImagePath!));
      var response = await request.send();

      if (response.statusCode == 200) {
        // رفع الصورة بنجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم رفع الصورة بنجاح، انتظر حتى يتم التأكيد'),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorDetailsScreen(therapistId: widget.therapistId)),
        );
      } else {
        // فشل رفع الصورة
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء رفع الصورة'),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // معالجة الخطأ
      print('Error uploading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء رفع الصورة'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                final pickedFile =
                await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 600, maxHeight: 600, imageQuality: 85);
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
                    color: Colors.black,
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
                File(pickedImagePath!),
                width: 100,
                height: 100,
              ),
            SizedBox(height: 20),
            Text(
              'قم برفع صورة لبطاقة الهوية أو أي وثيقة تثبت هويتك كمعالج نفسي',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('تأكيد التسجيل'),
            ),
          ],
        ),
      ),
    );
  }
}
