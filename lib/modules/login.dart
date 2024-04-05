import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chatmodel.dart';
import 'bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FnameController = TextEditingController();
  final SnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isShowed = true;
  IconData suffix = Icons.visibility;
  String _loginMessage = '';
/*
  // SharedPreferences key for storing login state
  final String _loginKey = 'isLoggedIn';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Function to check login status
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(_loginKey) ?? false;
    if (isLoggedIn) {
      // Redirect to BottomNav screen if user is logged in

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(

          ),
        ),
      );

    }
  }
*/
  // Function to handle login
  void _login() async {
    try {
      var url = Uri.parse('https://blessmate.onrender.com/Auth/Login');
      var body = jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
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
        if (responseData['isAuth']) {
          // Login successful
          setState(() {
            _loginMessage = 'تم تسجيل الدخول بنجاح';
          });

          // Show the message in a SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_loginMessage),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.green,
            ),
          );

          // Delay the navigation to the desired screen
          await Future.delayed(Duration(seconds: 5));

          // Navigate to the desired screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNav(),
            ),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('firstName', FnameController.text.trim());
          prefs.setString('lastName', SnameController.text.trim());
          prefs.setString('email', responseData['email']); // حفظ البريد الإلكتروني كما هو
          prefs.setString('id', responseData['id']); //




          // Store login state

          //await prefs.setBool(_loginKey, true);
        } else {
          setState(() {
            _loginMessage = 'فشل تسجيل الدخول، البريد الإلكتروني أو كلمة المرور غير صحيحة';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_loginMessage),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        setState(() {
          _loginMessage = 'حدث خطأ أثناء تسجيل الدخول';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_loginMessage),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Login Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    image: AssetImage('assets/images/img_9.png'),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "تسجيل الدخول",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        return value!.isEmpty ? "ادخل البريد الإلكتروني" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "البريد الإلكتروني",
                        prefixIcon: Container(
                          child: Icon(Icons.email),
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
                        return value!.isEmpty ? "ادخل كلمة المرور" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "كلمة المرور",
                        prefixIcon: Container(
                          child: Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(suffix),
                          onPressed: () {
                            setState(() {
                              isShowed = !isShowed;
                              suffix = isShowed ? Icons.visibility : Icons.visibility_off;
                            });
                          },
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
                        color: HexColor('00B4D8'),
                      ),
                      child: MaterialButton(
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "او",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          color: HexColor("FFFFFF"),
                          child: Icon(
                            Icons.facebook_outlined,
                            size: 33,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Google Sign-In button pressed
                        },
                        child: Container(
                          color: HexColor("FFFFFF"),
                          child: Image(
                            image: AssetImage(
                              'assets/images/icons8-google-48.png',
                            ),
                            width: 28,
                            height: 35,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          color: HexColor("FFFFFF"),
                          child: Image(
                            image: AssetImage(
                              'assets/images/icons8-twitter-96.png',
                            ),
                            width: 40,
                            height: 35,
                          ),
                        ),
                      ),
                    ],
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




