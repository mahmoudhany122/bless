import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widgets/appointment_date_widget.dart';
import '../widgets/appointment_time_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/progress_button.dart';
import 'appointment_review_summary_view.dart';

class AppointmentBottomSheet extends StatefulWidget {
  const AppointmentBottomSheet({super.key});

  @override
  State<AppointmentBottomSheet> createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {
  int? selectedDate;
  int? selectedTime;
  String? time = "";
  String? date = "";

  onChangeSelectedDate(int val) {
    setState(() {
      selectedDate = val;
      date =
      "${appointmentDates.where((element) => element.id == selectedDate).first.day} ${appointmentDates.where((element) => element.id == selectedDate).first.dayName}";
    });
  }

  onChangeSelectedTime(int val) {
    setState(() {
      selectedTime = val;
      time = appointmentTimes
          .where((element) => element.id == selectedTime)
          .first
          .time
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderWidget(
          icon: Icons.calendar_month,
          title: "Select Date",
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 123,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: appointmentDates.length,
            itemBuilder: (context, index) {
              var e = appointmentDates[index];
              return AppointmentDateWidget(
                appointmentDate: e,
                onTap: () => onChangeSelectedDate(e.id),
                selectedId: selectedDate ?? 1,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const HeaderWidget(
          icon: Icons.timelapse,
          title: "Select Time",
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 123,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: appointmentTimes.length,
            itemBuilder: (context, index) {
              var e = appointmentTimes[index];
              return AppointmentTimeWidget(
                appointmentTime: e,
                onTap: () => onChangeSelectedTime(e.id),
                selectedId: selectedTime ?? 0,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "This session can be rescheduled or canceled later than 24 hours before the session",
                maxLines: 3,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        AppProgressButton(
          text: "Select $date $time",
          width: MediaQuery.of(context).size.width,
          onPressed: (anim) {
            if (selectedDate != null && selectedTime != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentReviewView(
                    date: date ?? "",
                    time: time ?? "",
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}