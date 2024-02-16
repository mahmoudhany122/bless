import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart'
    as hex; // aliasing the external HexColor class

void _changePassword() async {
  // Add your logic here to validate and change the password
}

var myColor = hex.HexColor('00B4D8');

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isShowedCurrent = true;
  bool isShowedNew = true;
  bool isShowedConfirm = true;
  IconData suffixCurrent = Icons.visibility;
  IconData suffixNew = Icons.visibility;
  IconData suffixConfirm = Icons.visibility;
  String _changePasswordMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل كلمه المرور".tr),
      ),
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
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: currentPasswordController,
                      obscureText: isShowedCurrent,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل كلمة المرور الحالية".tr;
                        }
                        // إضافة اللوجيك للتحقق من صحة كلمة المرور الحالية
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "كلمة المرور الحالية".tr,
                        prefixIcon: Container(
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(suffixCurrent),
                          onPressed: () {
                            setState(() {
                              isShowedCurrent = !isShowedCurrent;
                              suffixCurrent = isShowedCurrent
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: myColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: myColor),
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
                      controller: newPasswordController,
                      obscureText: isShowedNew,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل كلمة المرور الجديدة".tr;
                        }
                        // إضافة اللوجيك للتحقق من صحة كلمة المرور الجديدة
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "كلمة المرور الجديدة".tr,
                        prefixIcon: Container(
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(suffixNew),
                          onPressed: () {
                            setState(() {
                              isShowedNew = !isShowedNew;
                              suffixNew = isShowedNew
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: myColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: myColor),
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
                      controller: confirmPasswordController,
                      obscureText: isShowedConfirm,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل تأكيد كلمة المرور الجديدة".tr;
                        } else if (value != newPasswordController.text) {
                          return "كلمة المرور غير متطابقة".tr;
                        }
                        // إضافة اللوجيك للتحقق من تأكيد كلمة المرور الجديدة
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "تأكيد كلمة المرور الجديدة".tr,
                        prefixIcon: Container(
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(suffixConfirm),
                          onPressed: () {
                            setState(() {
                              isShowedConfirm = !isShowedConfirm;
                              suffixConfirm = isShowedConfirm
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: myColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: myColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(17),
                        color: myColor,
                      ),
                      child: MaterialButton(
                        child:  Text(
                          "تأكيد التغييرات".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _changePassword();
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
