// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../data/data.dart';


class AppointmentTimeWidget extends StatelessWidget {
  const AppointmentTimeWidget({
    Key? key,
    required this.appointmentTime,
    required this.selectedId,
    required this.onTap,
  }) : super(key: key);
  final AppointmentTime appointmentTime;
  final int selectedId;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (appointmentTime.isBlocked == false) {
          onTap();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: selectedId == appointmentTime.id
              ? Colors.cyan
              : appointmentTime.isBlocked
              ? Colors.grey[300]
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: !appointmentTime.isBlocked ? Colors.cyan : Colors.grey[300]!,
          ),
        ),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Text(
          appointmentTime.time.toString(),
          style: TextStyle(
            color:
            selectedId == appointmentTime.id ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}