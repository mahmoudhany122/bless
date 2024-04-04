import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logindoc.dart';

class SignUpDoc extends StatefulWidget {
  const SignUpDoc({super.key});

  @override
  State<SignUpDoc> createState() => _SignUpDocState();
}

class _SignUpDocState extends State<SignUpDoc> {

  final FnameController = TextEditingController();
  final PhoneController = TextEditingController();
  final clinicAddressController = TextEditingController();
  final clinicNumberController = TextEditingController();
  final SnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ConfirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isShowed = true;
  bool isShowed1 = true;
  IconData suffix = Icons.visibility;
  IconData suffix1 = Icons.visibility;
  String _signupMessage = '';
  String confirmPassword = '';

  void _signup() async {
    var url = Uri.parse('https://blessmate.onrender.com/Auth/TherapistRegister');

    var body = jsonEncode({
      "firstName": FnameController.text.trim(),
      "lastName": SnameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "isMale": false,
      "phoneNumber": PhoneController.text.trim(),
      "clinicAddress":clinicAddressController.text.trim(),
      "clinicNumber":clinicNumberController.text.trim(),
    });

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['messages'] ?? 'تم تسجيل الحساب بنجاح'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green,
        ),
      );
      await Future.delayed(Duration(seconds: 5));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('firstName', FnameController.text.trim());
      prefs.setString('lastName', SnameController.text.trim());
      prefs.setString('email', emailController.text.trim());
      prefs.setString('phoneNumber', PhoneController.text.trim());
      prefs.setString('clinicAddress', clinicAddressController.text.trim());
      prefs.setString('clinicNumber', clinicNumberController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginDoc(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء عملية التسجيل'),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
      print('Signup Error: ${response.reasonPhrase}');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/img_7.png'),
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "اشتراك".tr,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: SnameController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل اسمك الاول " .tr: null;
                      },
                      decoration: InputDecoration(
                        labelText: 'الاسم الأول'.tr,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: FnameController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل اسمك الثانى" .tr: null;
                      },
                      decoration: InputDecoration(
                        labelText: 'الاسم الثانى'.tr,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل البريد الالكترونى".tr : null;
                      },
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        labelText: "بريد إلكتروني".tr,
                        prefixIcon: Container(
                          child: Icon(Icons.email),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: isShowed,
                      validator: (value) {
                        final passwordRegex =
                            r'^(?=.*?[0-9])(?=.*?[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{10,}$';
                        if (value!.isEmpty) {
                          return "ادخل كلمه المرور".tr;
                        } else if (!RegExp(passwordRegex).hasMatch(value)) {
                          return "  ادخل على الاققل 10 حروف و ارقام و ورمز خاص ".tr;
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                      decoration: InputDecoration(
                        labelText: "كلمة المرور".tr,
                        prefixIcon: Container(
                          child: Icon(
                            Icons.lock,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(suffix),
                          onPressed: () {
                            setState(() {
                              isShowed = !isShowed;
                              suffix = isShowed
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: ConfirmPasswordController,
                      obscureText: isShowed1,
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل تاكيد كلمه المرور".tr;
                        } else if (value != passwordController.text) {
                          return " كلمه المرور غير متطابقه".tr;
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                      decoration: InputDecoration(
                        labelText: " تاكيد كلمه المرور".tr,
                        prefixIcon: Container(
                          child: Icon(
                            Icons.lock,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(suffix1),
                          onPressed: () {
                            setState(() {
                              isShowed1 = !isShowed1;
                              suffix1 = isShowed1
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: PhoneController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل رقم الهاتف" .tr: null;
                      },
                      decoration: InputDecoration(
                        labelText: 'رقم الهاتف'.tr,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: clinicAddressController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل عنوان العياده" .tr: null;
                      },
                      decoration: InputDecoration(
                        labelText: 'عنوان العياده'.tr,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: clinicNumberController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل رقم العياده" .tr: null;
                      },
                      decoration: InputDecoration(
                        labelText: 'رقم العياده'.tr,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: HexColor('00B4D8'),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
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
                        child: Text(
                          "اشتراك".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _signup();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
