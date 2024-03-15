// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blessmate/widgets/stars_bar.dart';
import 'package:flutter/material.dart';

import '../modules/doctor_details_screen.dart';
import 'progress_button.dart';


class DoctorWidget extends StatelessWidget {
  const DoctorWidget({
    Key? key,
    this.isSummry = false,
  }) : super(key: key);
  final bool isSummry;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DoctorDetailsScreen(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 10,
              offset: const Offset(0, 1),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://th.bing.com/th/id/OIP.P1IfJNdtz7GmKkfPqR2yNAHaIO?w=169&h=187&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                height: 95,
                fit: BoxFit.cover,
                width: 95,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 95,
                    height: 95,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Dr. Herbert Wysocki.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "psychologist",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Specializes in treating:",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Anxiety, stress, depression",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  StarsBar(stars: 5)
                ],
              ),
            ),
            if (!isSummry) const SizedBox(width: 12),
            if (!isSummry)
              AppProgressButton(
                height: 38,
                width: 75,
                fontSize: 13,
                text: "Book now",
                onPressed: (anim) {},
              ),
          ],
        ),
      ),
    );
  }
}