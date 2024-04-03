import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/progress_button.dart';
import '../widgets/show_bottom_sheet.dart';
import '../widgets/stars_bar.dart';
import 'appointment_bottom_sheet.dart';
import 'doctime.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  File? imageSelect;
  final _imagePicker = ImagePicker();
  String bigContainerText = '';
  String smallContainerText = '';
  Future<void> pickImageCamera() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        imageSelect = File(pickedImage.path);
      }
    });
  }

  Future<void> pickImageGallery() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        imageSelect = File(pickedImage.path);
      }
    });
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
                              width: 50,
                              height: 50,
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. Herbert Wysocki.",
                          style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "psychologist",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Phd Counselling Psychology",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "6+ yrs experience",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        StarsBar(stars: 5)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height:100, // Set a specific height or use constraints to provide bounds
                      child: Expanded(
                        child: Container(
                          height: 0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                            border: Border.all(color:  Colors.cyan, width: 2), // Define the border color and width
                            color: Colors.white, // Set the background color to white
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'اكتب نبذة مختصرة عنك',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                // Handle text input here
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50, // Set a specific height or use constraints to provide bounds
                      child: Flexible(
                        child: Container(
                          height: 0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                            border: Border.all(color:  Colors.cyan, width: 2), // Define the border color and width
                            color: Colors.white, // Set the background color to white
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'ادخل التعليم و التخصص',
                                hintStyle: TextStyle(color: Colors.black),

                              ),
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {
                                // Handle text input here
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: AppProgressButton(
                radius: 8,
                text: "قم بتحديد مواعيد العمل و الحجز المتاحة",
                width: MediaQuery.of(context).size.width - 40,
                onPressed: (anim) {
                  mainShowDialog(
                    context: context,
                    height: MediaQuery.of(context).size.height / 1.5,
                    page: const Doctime(),
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
