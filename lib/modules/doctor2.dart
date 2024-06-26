import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doctor1.dart';

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

class HomeDoctor2 extends StatefulWidget {
  final int therapistId;

  const HomeDoctor2({Key? key, required this.therapistId}) : super(key: key);

  @override
  State<HomeDoctor2> createState() => _HomeDoctor2State();
}

class _HomeDoctor2State extends State<HomeDoctor2> {
  List<Appointment> appointments = [];
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
            age: json['age'] ?? 0,
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

  void removeAppointment(int id) {
    print('Attempting to remove appointment with ID: $id');
    setState(() {
      appointments.removeWhere((appointment) => appointment.id == id);
      print('Remaining appointments: ${appointments.map((a) => a.id).toList()}');
      // Ensure the list is updated
      hasData = appointments.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "جدول المواعيد".tr,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasData
          ? ListView.separated(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCard(
            appointment: appointment,
            removeAppointment: removeAppointment,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
      )
          : Center(child: Text(errorMessage)),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final void Function(int) removeAppointment;

  const AppointmentCard({Key? key, required this.appointment, required this.removeAppointment}) : super(key: key);

  Future<void> saveAppointmentDetails(Appointment appointment) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('appointment_id', appointment.id);
    prefs.setString('appointment_firstName', appointment.firstName ?? '');
    prefs.setString('appointment_lastName', appointment.lastName ?? '');
    prefs.setString('appointment_phoneNumber', appointment.phoneNumber ?? '');
    prefs.setString('appointment_email', appointment.email ?? '');
    prefs.setInt('appointment_age', appointment.age);
    prefs.setBool('appointment_isMale', appointment.isMale);
    prefs.setString('appointment_photoUrl', appointment.photoUrl ?? '');
    prefs.setString('appointment_inTime', appointment.inTime ?? '');
    print('Appointment details saved for ID: ${appointment.id}');
  }

  String formatDate(String? dateStr) {
    if (dateStr == null) return '';
    final dateTime = DateTime.parse(dateStr);
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
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
                      Icon(Icons.access_time, color: HexColor("00B4D8"), size: 12),
                      SizedBox(width: 2),
                      Text(
                        formatDate(appointment.inTime),
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('تأكيد'.tr),
                            content: Text('هل قمت بإكمال الجلسة بالفعل؟'.tr),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('لا'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await saveAppointmentDetails(appointment);
                                  removeAppointment(appointment.id); // Remove the appointment from the list
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('نعم'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: FaIcon(FontAwesomeIcons.checkCircle, color: Colors.green, size: 30),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('تأكيد'.tr),
                            content: Text('هل تريد بالفعل إلغاء الجلسة؟'.tr),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('لا'.tr),
                              ),
                              TextButton(
                                onPressed: () async {
                                  removeAppointment(appointment.id); // Remove the appointment from the list
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('نعم'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: FaIcon(FontAwesomeIcons.timesCircle, color: Colors.red, size: 30),
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
