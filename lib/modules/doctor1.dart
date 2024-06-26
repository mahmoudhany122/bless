import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doctor2.dart';

class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({Key? key}) : super(key: key);

  Future<Appointment?> getSavedAppointmentDetails() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('appointment_id')) {
      return null;
    }
    return Appointment(
      id: prefs.getInt('appointment_id')!,
      firstName: prefs.getString('appointment_firstName'),
      lastName: prefs.getString('appointment_lastName'),
      phoneNumber: prefs.getString('appointment_phoneNumber'),
      email: prefs.getString('appointment_email'),
      age: prefs.getInt('appointment_age')!,
      isMale: prefs.getBool('appointment_isMale')!,
      photoUrl: prefs.getString('appointment_photoUrl'),
      inTime: prefs.getString('appointment_inTime'),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(String? dateStr) {
      if (dateStr == null) return '';
      final dateTime = DateTime.parse(dateStr);
      final formatter = DateFormat('yyyy-MM-dd HH:mm');
      return formatter.format(dateTime);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("تاريخ الاستشارات"),
      ),
      body: FutureBuilder<Appointment?>(
        future: getSavedAppointmentDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return Center(child: Text("ليس هناك استشارات مكتمله بعد"));
          } else {
            final appointment = snapshot.data!;
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
                            : Placeholder(), // Use placeholder if photo URL is null
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "ميعاد ",
                                style: Theme.of(context).textTheme.bodyText1,

                              ),
                              SizedBox(width: 4),
                              Text(
                                "مكتمل ",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                ),

                              ),

                            ],
                          ),
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
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
