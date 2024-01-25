import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bottom_nav.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => _ResighterScreenState();
}

class _ResighterScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isShowed = true;
  IconData suffix = Icons.visibility;
  String _signupMessage = '';

  // Function to handle Google Sign-In
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // User sign-in successful
        setState(() {
          _signupMessage = 'لقد تم تسجيل دخولك بنجاح';
        });

        // Show the message in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_signupMessage),
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

        return userCredential;
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
    return null;
  }

  void _signup() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // User signup successful
      setState(() {
        _signupMessage = 'لقد تم تسجيل دخولك بنجاح';
      });

      // Show the message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_signupMessage),
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
    } catch (error) {
      // Signup failed, handle the error
      setState(() {
        _signupMessage = 'هذا الحساب غير موجود حاول  مره ثانيه';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_signupMessage),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
      print('Signup Error: $error');
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
                        return value!.isEmpty ? "ادخل البريد الالكترونى" : null;
                      },
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        labelText: "بريد إلكتروني",
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
                          return "ادخل كلمه المرور";
                        } else if (!RegExp(passwordRegex).hasMatch(value)) {
                          return "  ادخل على الاققل 10 حروف و ارقام و ورمز خاص ";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                      decoration: InputDecoration(
                        labelText: "كلمة المرور",
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
                        child: const Text(
                          "تسجيل الدخول",
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
                          // Call the function for Google Sign-In
                          await _signInWithGoogle();
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
