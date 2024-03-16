// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class AppointmentDate {
  final int id;
  final int day;
  final bool isBlocked;
  final String dayName;
  AppointmentDate({
    required this.id,
    required this.day,
    required this.isBlocked,
    required this.dayName,
  });
}

class AppointmentTime {
  final int id;
  final String time;
  final bool isBlocked;

  AppointmentTime({
    required this.id,
    required this.time,
    required this.isBlocked,
  });
}

class PaymentMethod {
  final int id;
  final String name;
  final IconData icon;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
  });
}

List<AppointmentDate> appointmentDates = [
  AppointmentDate(id: 0, day: 1, dayName: "Sat", isBlocked: true),
  AppointmentDate(id: 1, day: 2, dayName: "Sun", isBlocked: false),
  AppointmentDate(id: 2, day: 3, dayName: "Mon", isBlocked: false),
  AppointmentDate(id: 3, day: 4, dayName: "Tue", isBlocked: false),
];
List<AppointmentTime> appointmentTimes = [
  AppointmentTime(id: 0, time: "6 PM", isBlocked: false),
  AppointmentTime(id: 1, time: "7 PM", isBlocked: false),
  AppointmentTime(id: 2, time: "8 PM", isBlocked: true),
  AppointmentTime(id: 3, time: "9 PM", isBlocked: false),
];

List<PaymentMethod> paymentMethod = [
  PaymentMethod(
    id: 0,
    icon: Icons.credit_card,
    name: "Credit or debit card",
  ),
  PaymentMethod(
    id: 1,
    icon: Icons.gpp_good_outlined,
    name: "Google Pay",
  ),
  PaymentMethod(
    id: 2,
    icon: Icons.apple_outlined,
    name: "Apple Pay",
  ),
  PaymentMethod(
    id: 3,
    icon: Icons.paypal,
    name: "PayPal",
  ),
];