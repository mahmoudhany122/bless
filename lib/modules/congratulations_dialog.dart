
import 'package:flutter/material.dart';
import '../widgets/progress_button.dart';
import 'appointment_final_summary_view.dart';

class CongratulationsDialog extends StatelessWidget {
  const CongratulationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/img_38.png",
                height: 135,
                width: 150,
              ),
              const Text(
                "Congratulations!",
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Appointment Successfully Booked. You Will Receive A Notification And The Doctor You Selected Will Contact you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              AppProgressButton(
                text: "View Appointment",
                height: 55,
                width: MediaQuery.of(context).size.width,
                onPressed: (onPressed) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppointmentFinalView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AppProgressButton(
                text: "Cancle",
                height: 55,
                backgroundColor: Colors.white,
                isBordered: true,
                textColor: Colors.cyan,
                width: MediaQuery.of(context).size.width,
                onPressed: (onPressed) {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}