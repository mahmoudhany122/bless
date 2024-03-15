
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/doctor_widget.dart';
import '../widgets/main_text_form.dart';
import '../widgets/progress_button.dart';
import 'chat_doc.dart';
import 'docchat.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Your Therapist",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Expanded(
                    child: MainTextField(
                      fillColor: Colors.white,
                      borderRadius: 21,
                      hint: "Dr.s",
                      prefixIcon: Icon(
                        Iconsax.search_normal,
                        color: Colors.cyan,
                      ),
                      suffixIcon: Icon(
                        Iconsax.microphone,
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppProgressButton(
                    height: 38,
                    width: 75,
                    fontSize: 13,
                    text: "Search",
                    onPressed: (anim) {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => MyTabbedScreen(),));
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sort,
                        color: Colors.cyan,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Sort",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.filter,
                        color: Colors.cyan,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "All Therapists",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.separated(
              itemCount: 100,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return const DoctorWidget();
              },
            )
          ],
        ),
      ),
    );
  }
}