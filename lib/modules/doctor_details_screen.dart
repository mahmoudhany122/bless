import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../widgets/progress_button.dart';
import '../widgets/show_bottom_sheet.dart';
import 'doctime.dart';

class DoctorDetailsScreen extends StatefulWidget {

  const DoctorDetailsScreen({Key? key}) : super(key: key);

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  File? imageSelect;
  final _imagePicker = ImagePicker();
  var descriptionController = TextEditingController();
  var specialityController = TextEditingController();

  Future<void> pickImageCamera() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _showDialog(pickedImage.path);
    }
  }

  Future<void> pickImageGallery() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _showDialog(pickedImage.path);
    }
  }

  Future<void> _showDialog(String imagePath) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Description and Speciality'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Enter Description'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: specialityController,
                decoration: InputDecoration(hintText: 'Enter Speciality'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without sending
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                sendTherapistProfile(imagePath);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendTherapistProfile(String imagePath) async {
    try {
      final pickedImage = File(imagePath);
      List<int> imageBytes = await pickedImage.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var response = await http.post(
        Uri.parse('https://blessmate.onrender.com/Therapist/TherapistProfile?id={TherapistId}'),
        body: {
          'decreption': descriptionController.text,
          'speciality': specialityController.text,
          'profilePicture': base64Image,
        },
      );


      if (response.statusCode == 200) {
        print('Profile updated successfully.');
      } else {
        print('Error updating profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Therapist Details",
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
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
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
                          pickImageCamera();
                          pickImageGallery();
                        },
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
                          hintText: 'Enter Description',
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
                          hintText: 'Enter Speciality',
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
            Center(
              child: AppProgressButton(
                radius: 8,
                text: "قم بتحديد مواعيد العمل و الحجز المتاحة",
                width: MediaQuery.of(context).size.width - 40,
                onPressed: (anim) {
                  mainShowDialog(
                    context: context,
                    height: MediaQuery.of(context).size.height / 1.5,
                    page:  Doctime(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Dr. Herbert Wysocki.",
//                           style: TextStyle(
//                             color: Colors.cyan,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                           ),
//                         ),
//                         Text(
//                           "psychologist",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           "Phd Counselling Psychology",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Text(
//                           "6+ yrs experience",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         StarsBar(stars: 5)
//                       ],
//                     ),
//                   ),