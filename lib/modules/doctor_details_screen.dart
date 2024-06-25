import 'dart:convert';
import 'dart:io';
import 'package:blessmate/modules/tap_bar_doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final int therapistId;

  const DoctorDetailsScreen({Key? key, required this.therapistId}) : super(key: key);

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  File? imageSelect;
  final _imagePicker = ImagePicker();
  var descriptionController = TextEditingController();
  var specialityController = TextEditingController();
  String? imagePath;

  Future<void> pickImageCamera() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageSelect = File(pickedImage.path);
      });
      _showDialog(pickedImage.path);
    }
  }

  Future<void> pickImageGallery() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageSelect = File(pickedImage.path);
      });
      _showDialog(pickedImage.path);
    }
  }

  Future<void> _showDialog(String imagePath) async {
    this.imagePath = imagePath;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('قم بادخال نبذه مختصره عنك والتخصص'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'اكتب نبذة مختصرة عنك'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: specialityController,
                decoration: InputDecoration(hintText: 'ادخل التعليم و التخصص'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without sending
              },
              child: Text('الغاء'),
            ),
            TextButton(
              onPressed: () {
                sendTherapistProfile();
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('ارسال'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendTherapistProfile() async {
    try {
      if (imagePath == null) {
        print('Please select an image.');
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://blessmate.onrender.com/Therapist/TherapistProfile?id=${widget.therapistId}'),
      );

      // Add description and speciality as text fields
      request.fields['decreption'] = descriptionController.text;
      request.fields['speciality'] = specialityController.text;

      // Add the image as a file
      request.files.add(await http.MultipartFile.fromPath(
        'profilePicture',
        imagePath!,
        contentType: MediaType('image', 'jpeg'), // Change this according to the uploaded image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Profile updated successfully.');
        Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarScreen(therapistId: widget.therapistId)));
      } else {
        print('Error updating profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('معرض الصور'),
                onTap: () {
                  pickImageGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('الكاميرا'),
                onTap: () {
                  pickImageCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تفاصيل المعالج",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        imageSelect != null
                            ? Image.file(
                          imageSelect!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        )
                            : Image.asset(
                          "assets/images/img_12.png",
                          width: 100,
                          height: 100,
                        ),
                        IconButton(
                          onPressed: () {
                            _showImageSourceActionSheet(context);
                          },
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyan, width: 2),
                        color: Colors.white,
                      ),
                      child: TextField(
                        maxLines: 3,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: '  اكتب نبذة مختصرة عنك  '.tr,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyan, width: 2),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: specialityController,
                        decoration: InputDecoration(
                          hintText: '   ادخل التعليم و التخصص    '.tr,
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: HexColor('00B4D8'),
                  ),
                  child: MaterialButton(
                    child: Text("الذهاب الى الصفحه الرئيسيه".tr,
                        style: Theme.of(context).textTheme.button),
                    onPressed: sendTherapistProfile, // Call sendTherapistProfile method when the button is pressed
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
