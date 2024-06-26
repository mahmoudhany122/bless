import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme =ThemeData(
  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: HexColor('333739'),

  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness:Brightness.light,
    ),
    backgroundColor:HexColor('333739'),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 23.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor:HexColor("566063"),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  textTheme: TextTheme  (
    bodyText1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 23.0,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 17,

    ),
    headline5  : TextStyle(
      color: Colors.white,
      fontSize: 16,

    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    selectedIconTheme:IconThemeData(
      color: Colors.white,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.white,


  ),
);


ThemeData lightTheme = ThemeData(
  primarySwatch:Colors.cyan,
  scaffoldBackgroundColor:Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor:Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(
      color:Colors.black,
    ),
  ),
  iconTheme: IconThemeData(
      color:Colors.black
  ),
  backgroundColor: Colors.grey[100],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: HexColor('00B4D8'),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,

      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
      headline1:TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w300,
        color: HexColor('00B4D8'),
      ) ,
      headline2:TextStyle(
        fontSize:35.0,
        fontWeight: FontWeight.w300,
        color: HexColor('00B4D8'),
      ) ,
      headline6: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      headline5  : TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold

      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 23.0,
        color: Colors.black,
      ),
      button:  TextStyle(
          color: Colors.white,
          fontSize: 20,
          ),
      ),
);