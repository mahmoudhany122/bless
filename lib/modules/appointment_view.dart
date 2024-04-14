import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../widgets/doctor_widget.dart';
import '../widgets/main_text_form.dart';
import '../widgets/progress_button.dart';
import '../widgets/show_bottom_sheet.dart';
import '../widgets/stars_bar.dart';
import 'appointment_bottom_sheet.dart';
import 'chat_doc.dart';
import 'docchat.dart';
import 'doctor_details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class AppointmentView extends StatefulWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  List<dynamic> therapistsData = [];
  bool isLoading = true; // Add isLoading variable

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
    await http.get(Uri.https('blessmate.onrender.com', '/Patient/GetTherapistes'));

    if (response.statusCode == 200) {
      setState(() {
        therapistsData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load therapists data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Your Therapist",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body:  isLoading
          ? Center(child: Center(
            child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
          )) // Show CircularProgressIndicator if isLoading is true
          : SingleChildScrollView(
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
                    onPressed: (anim) {},
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
              itemCount: therapistsData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final therapist = therapistsData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>DetailsDocAppontioment(therapist: therapist) ,
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
                            therapist['photoUrl'] ?? 'https://th.bing.com/th/id/R.215c1ff399e961851cc11a7810886a0e?rik=oZfxvnavGwz6cA&riu=http%3a%2f%2fwww.writergirl.com%2fwp-content%2fuploads%2f2014%2f11%2fDoctor-790X1024.jpg&ehk=CmnYm47Si7SLogCKQcVQ9Onueou53ycpcjvFFc3Ej00%3d&risl=&pid=ImgRaw&r=0',
                            height: 95,
                            fit: BoxFit.fill,
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
                                "${therapist['firstName'] ?? 'Unknown'} ${therapist['lastName'] ?? 'Therapist'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                therapist['speciality'] ?? 'Specialty not specified',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Years of Experience: ${therapist['yearsExperience'] ?? 'Unknown'}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              StarsBar(stars: 4) // Assuming it's a star rating widget
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
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
              },
              separatorBuilder: (context, index) => SizedBox(height: 15),
            )
          ],
        ),
      ),
    );
  }

}
class DetailsDocAppontioment extends StatefulWidget {
  final Map<String, dynamic> therapist;
  const DetailsDocAppontioment({Key? key, required this.therapist}) : super(key: key);

  @override
  State<DetailsDocAppontioment> createState() => _DetailsDocAppontiomentState();
}

class _DetailsDocAppontiomentState extends State<DetailsDocAppontioment> {

  @override
  Widget build(BuildContext context) {
    final therapist = widget.therapist;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      therapist['photoUrl'] ?? 'https://th.bing.com/th/id/R.215c1ff399e961851cc11a7810886a0e?rik=oZfxvnavGwz6cA&riu=http%3a%2f%2fwww.writergirl.com%2fwp-content%2fuploads%2f2014%2f11%2fDoctor-790X1024.jpg&ehk=CmnYm47Si7SLogCKQcVQ9Onueou53ycpcjvFFc3Ej00%3d&risl=&pid=ImgRaw&r=0',
                      height: 95,
                      fit: BoxFit.fill,
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
                          " Dr. ${therapist['firstName'] ?? 'Unknown'} ${therapist['lastName'] ?? 'Therapist'}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.cyan,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          therapist['speciality'] ?? 'Specialty not specified',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          "Years of Experience: ${therapist['yearsExperience'] ?? 'Unknown'}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        StarsBar(stars: 4)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: AppProgressButton(
                radius: 8,
                text: " Have free chat with me ",
                width: MediaQuery.of(context).size.width - 40,
                onPressed: (anim) {
                  // Extracting the email

                  String therapistEmail = therapist['email'] ?? '';
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ChatScreenDoc(userData: {'email': therapistEmail,},
                  ),
                  ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: AppProgressButton(
                radius: 8,
                text: "Check available appointment",
                width: MediaQuery.of(context).size.width - 40,
                onPressed: (anim) {
                  mainShowDialog(
                    context: context,
                    height: MediaQuery.of(context).size.height / 1.5,
                    page: const AppointmentBottomSheet(),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['description'] ?? 'description is not specified'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Specialization",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['speciality'] ?? '"speciality" is not spectified'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "clinicAddress",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['clinicAddress'] ?? '"clinicAddress" is not spectified'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "clinicNumber",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['clinicNumber'] ?? '"clinicAddress" is not spectified'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Contact Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist["email"] ?? '"email" is not spectified'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
