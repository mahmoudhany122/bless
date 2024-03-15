// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../data/data.dart';

class AppointmentDateWidget extends StatelessWidget {
  const AppointmentDateWidget({
    Key? key,
    required this.appointmentDate,
    required this.selectedId,
    required this.onTap,
  }) : super(key: key);
  final AppointmentDate appointmentDate;
  final int selectedId;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (appointmentDate.isBlocked == false) {
          onTap();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: selectedId == appointmentDate.id
              ?Colors.cyan
              : appointmentDate.isBlocked
              ? Colors.grey[300]
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: !appointmentDate.isBlocked ? Colors.cyan : Colors.grey[300]!,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              appointmentDate.day.toString(),
              style: TextStyle(
                color: selectedId == appointmentDate.id
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(
              appointmentDate.dayName,
              style: TextStyle(
                color: selectedId == appointmentDate.id
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}