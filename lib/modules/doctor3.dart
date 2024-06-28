import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Appointment {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber; // Make phone number nullable
  final String? email;
  final int age;
  final bool isMale;
  final String? photoUrl; // Make photo URL nullable
  final String? inTime;

  Appointment({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.age,
    required this.isMale,
    required this.photoUrl,
    required this.inTime,
  });
}

class HomeDoctor3 extends StatefulWidget {
  final int therapistId;
  const HomeDoctor3({Key? key, required this.therapistId}) : super(key: key);
  @override
  State<HomeDoctor3> createState() => _HomeDoctor3State();
}

class _HomeDoctor3State extends State<HomeDoctor3> {

  late List<Appointment> appointments;
  bool isLoading = true;
  bool hasData = true;
  String errorMessage = ''; // Error message if data retrieval fails

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://blessmate.onrender.com/Therapist/GetTherapistPatient?id=${widget.therapistId}'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          appointments = data
              .map((json) => Appointment(
            id: json['id'],
            firstName: json['firstName'] ?? '',
            lastName: json['lastName'] ?? '',
            phoneNumber: json['phoneNumber'],
            email: json['email'] ?? '',
            age: json['age'] ?? " العمر غير معرف ",
            isMale: json['isMale'] ?? false,
            photoUrl: json['photoUrl'],
            inTime: json['inTime'],
          ))
              .toList();
          isLoading = false;
          hasData = appointments.isNotEmpty;
        });
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
        hasData = false;
        errorMessage = 'Failed to load appointments. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("إدارة المرضى".tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true, ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasData
          ? ListView.separated(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCards(
            appointment: appointment,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
      )
          : Center(child: Text(errorMessage)),
    );
  }
}

class AppointmentCards extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCards({Key? key, required this.appointment,}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    String formatDate(String? dateStr) {
      if (dateStr == null) return '';
      final dateTime = DateTime.parse(dateStr);
      final formatter = DateFormat('yyyy-MM-dd HH:mm');
      return formatter.format(dateTime);
    }

    return GestureDetector(
      onTap: () {
        // Handle appointment card tap
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: HexColor("E4E4E7"), width: 2),
            boxShadow: [
              BoxShadow(color: HexColor("E4E4E7"), blurRadius: 5, offset: Offset(1, 1)),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(right: 10, left: 10, top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: appointment.photoUrl != null
                    ? Image.network(appointment.photoUrl!)
                    : Image.asset("assets/images/IMG_20240219_034656_363.jpg"), // Use placeholder if photo URL is null
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Text(
                    ' ${appointment.lastName} ${appointment.firstName}',
                    style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        ' ${appointment.email}',
                        style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.call, color: HexColor("00B4D8"), size: 20),

                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        ' العمر'.tr,
                        style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 2),
                      Text(
                        ' ${appointment.age }',
                        style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
