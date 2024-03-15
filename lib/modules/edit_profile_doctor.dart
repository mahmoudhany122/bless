import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'bottom_nav.dart';

class EditProfileDoctor extends StatefulWidget {

  @override
  _EditProfileDoctorState createState() => _EditProfileDoctorState();
}

class _EditProfileDoctorState extends State<EditProfileDoctor> {
  File? imageSelect;
  final _imagePicker = ImagePicker();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedDate;
  final _countryController = TextEditingController();
  final _diseaseController = TextEditingController();
  String? selectedDisease;
  List<String> diseases = ['smoking ', 'dhd', 'forcle'];

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

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate.toString().split(' ')[0];
        _ageController.text =
        _selectedDate!; // Update the text field with the selected date
      });
    }
  }

  void saveInformation() {
    final name = _nameController.text;
    final age = _ageController.text;
    final country = _countryController.text;
    final disease = _diseaseController.text;

    // Do something with the user information (e.g., save to a database)
    print('اسم المستحدم: $name');
    print('العمر: $age');
    print('الهاتف: $country');
    print('البريد الالكترونى: $disease');

    // Show a dialog to indicate that the information has been saved
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Information Saved'),
        content: Text('User information has been saved.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNav(),
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  String _selectedLanguage = 'ar';
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _countryController.dispose();
    _diseaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "تعديل الملف الشخصي".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child :Directionality(
                textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: imageSelect != null
                                ? Image.file(
                              imageSelect!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            )
                                : Image.asset( "assets/images/img_15.png",
                            width: 400,
                            height: 400,
                            ),
                            radius: 80,
                          ),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              pickImageCamera();
                              pickImageGallery();
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          radius: 20,
                          backgroundColor: HexColor('00B4D8'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(

                        padding: EdgeInsets.all(15),
                        width: 336,
                        height: 379,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border:  Border.all (color: Colors.grey),
                        ),
                        child :Directionality(
                            textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                            child:Column (
                              children: [
                                TextField(
                                  textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,

                                  decoration: InputDecoration(
                                    hintText: 'اسم المستخدم'.tr,
                                  ),
                                ),
                                TextField(
                                  textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                                  controller: _diseaseController,
                                  onTap: selectDate,
                                  decoration: InputDecoration(
                                    hintText: 'بريد إلكترونى'.tr,
                                  ),
                                ),
                                TextField(
                                  textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                                  controller: _countryController,
                                  onTap: selectDate,
                                  decoration: InputDecoration(
                                    hintText: 'هاتف'.tr,
                                  ),
                                ),
                                TextField(
                                  textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                                  controller: _ageController,
                                  onTap: selectDate,
                                  decoration: InputDecoration(
                                    hintText: 'تاريخ الميلاد '.tr,
                                  ),
                                ),
                                TextField(
                                  textDirection:  _selectedLanguage =='ar' ? TextDirection.rtl : TextDirection.ltr,
                                  controller: _diseaseController,
                                  onTap: selectDate,
                                  decoration: InputDecoration(
                                    hintText: 'عنوان'.tr,
                                  ),
                                ),

                              ],)


                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: HexColor('00B4D8'),
                        ),
                        child: MaterialButton(
                          child:  Text(
                            "حفظ".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          onPressed: saveInformation,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )  );
  }
}

