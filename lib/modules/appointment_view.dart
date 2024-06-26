import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/data.dart';
import '../widgets/appointment_date_widget.dart';
import '../widgets/appointment_time_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/main_text_form.dart';
import '../widgets/progress_button.dart';
import '../widgets/show_bottom_sheet.dart';
import '../widgets/stars_bar.dart';
import 'chat_doc.dart';
import 'doctor_details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

class AppointmentView extends StatefulWidget {
  final int? patientId;
  const AppointmentView({Key? key, this.patientId}) : super(key: key);

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  List<dynamic> therapistsData = [];
  List<dynamic> searchResults = [];
  bool isLoading = true;

  Set<int> favoriteTherapistIds = {};

  @override
  void initState() {
    super.initState();
    fetchData(); // تحميل البيانات عند فتح الصفحة
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.https('blessmate.onrender.com', '/Patient/GetTherapistes'));

    if (response.statusCode == 200) {
      setState(() {
        therapistsData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load therapists data');
    }
  }

  void search(String query) {
    List<dynamic> searchResults = therapistsData.where((therapist) {
      String fullName = "${therapist['firstName']} ${therapist['lastName']}".toLowerCase();
      return fullName.contains(query.toLowerCase());
    }).toList();

    setState(() {
      this.searchResults = searchResults;
    });
  }

  void toggleFavorite(int therapistId, Map<String, dynamic> therapist) {
    setState(() {
      if (favoriteTherapistIds.contains(therapistId)) {
        favoriteTherapistIds.remove(therapistId);
      } else {
        favoriteTherapistIds.add(therapistId);
        savePatientData(therapist);
      }
    });
  }

  void savePatientData(Map<String, dynamic> therapist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // حفظ بيانات المعالج باستخدام SharedPreferences
    await prefs.setString('therapistFirstName', therapist['firstName']);
    await prefs.setString('therapistLastName', therapist['lastName']);
    await prefs.setString('therapistPhotoUrl', therapist['photoUrl']);
    await prefs.setString('therapistSpeciality', therapist['speciality']);
    await prefs.setString('therapistYearsExperience', therapist['yearsExperience']);

    print('Saved therapist data: ${therapist['firstName']} ${therapist['lastName']}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اختر المعالج الخاص بك".tr,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: MainTextField(
                    onChange: (value) {
                      search(value);
                    },
                    fillColor: Theme.of(context).backgroundColor,
                    borderRadius: 21,
                    hint: "دكتور".tr,
                    prefixIcon: Icon(
                      Iconsax.search_normal,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AppProgressButton(
                  height: 38,
                  width: 75,
                  fontSize: 13,
                  text: "بحث".tr,
                  onPressed: (anim) {},
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: searchResults.isNotEmpty ? searchResults.length : therapistsData.length,
              itemBuilder: (context, index) {
                final therapist = searchResults.isNotEmpty ? searchResults[index] : therapistsData[index];
                final therapistId = therapist['id'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsDocAppontioment(
                          therapist: therapist,
                          patientId: widget.patientId ?? 0,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color:Theme.of(context).backgroundColor!,
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
                            therapist['photoUrl'] ??
                                'https://th.bing.com/th/id/R.215c1ff399e961851cc11a7810886a0e?rik=oZfxvnavGwz6cA&riu=http%3a%2f%2fwww.writergirl.com%2fwp-content%2fuploads%2f2014%2f11%2fDoctor-790X1024.jpg&ehk=CmnYm47Si7SLogCKQcVQ9Onueou53ycpcjvFFc3Ej00%3d&risl=&pid=ImgRaw&r=0',
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
                                "${therapist['lastName'] ?? 'Therapist'}${therapist['firstName'] ?? 'Unknown'} ",
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
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                favoriteTherapistIds.contains(therapistId)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteTherapistIds.contains(therapistId) ? Colors.cyan : Colors.cyan,
                              ),
                              onPressed: () {
                                toggleFavorite(therapistId, therapist);
                              },
                            ),
                            AppProgressButton(
                              height: 38,
                              width: 75,
                              fontSize: 13,
                              text: "احجز الان".tr,
                              onPressed: (anim) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 15),
            ),
          ),
        ],
      ),
    );
  }
}


class DetailsDocAppontioment extends StatefulWidget {
  final Map<String, dynamic> therapist;
  final int patientId;

  const DetailsDocAppontioment({
    Key? key,
    required this.therapist,
    required this.patientId,
  }) : super(key: key);

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
                      therapist['photoUrl'] ??
                          'https://th.bing.com/th/id/R.215c1ff399e961851cc11a7810886a0e?rik=oZfxvnavGwz6cA&riu=http%3a%2f%2fwww.writergirl.com%2fwp-content%2fuploads%2f2014%2f11%2fDoctor-790X1024.jpg&ehk=CmnYm47Si7SLogCKQcVQ9Onueou53ycpcjvFFc3Ej00%3d&risl=&pid=ImgRaw&r=0',
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
                          " دكتور : ${therapist['firstName'] ?? 'Unknown'} ${therapist['lastName'] ?? 'Therapist'}".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.cyan,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          therapist['speciality'] ?? 'التخصص غير معروف'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          "Years of Experience: ${therapist['yearsExperience'] ?? 'غير معروف'.tr}",
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
                text: " عمل محادثه مجانيه معى".tr,
                width: MediaQuery.of(context).size.width - 40,
                onPressed: (anim) {
                  // Extracting the email

                  String therapistEmail = therapist['email'] ?? 'البريد الالكترونى غير معروف';
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
                text: "التحقق من الموعد المتاح".tr,
                width: MediaQuery.of(context).size.width - 40,
                onPressed: (anim) {
                  String clinicNumber = therapist['clinicNumber'] ?? 'N/A';
                  mainShowDialog(
                    context: context,
                    height: MediaQuery.of(context).size.height / 1.5,
                    page: AppointmentBottomSheet(
                     therapistId: therapist['id'],
                     patientId: widget.patientId,
                      clinicNumber: clinicNumber,
                    ),
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
                    "عن الطبيب".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['description'] ?? 'الوصف غير معرف'.tr} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "التخصص".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['speciality'] ?? '" التخصص غير معروف'.tr} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "عنوان العياده".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['clinicAddress'] ?? '"عنوان العياده غير معروف'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "رقم العياده".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist['clinicNumber'] ?? '"رقم العياده غير معرف'} ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "بيانات التواصل".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${therapist["email"] ?? '"البريد الكترونى غير معروف'} ",
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





class AppointmentBottomSheet extends StatefulWidget {
  final int therapistId; // تعريف متغير لتخزين معرف المعالج المحدد
  final int patientId; // إضافة patientId هنا
  final String clinicNumber; // تعريف متغير لتخزين رقم العيادة

  const AppointmentBottomSheet({
    Key? key,
    required this.therapistId,
    required this.patientId,
    required this.clinicNumber,
  }) : super(key: key);

  @override
  State<AppointmentBottomSheet> createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {
  String? time = "";
  String? date = "";

  Future<void> makeAppointment() async {
    int therapistId = widget.therapistId;
    int patientId = widget.patientId;

    // Formatting the selected date and time
    String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String formattedTime = DateFormat("HH:mm").format(DateTime.now());

    // Construct the request body as a JSON string
    String requestBody = jsonEncode({
      "therpistId": therapistId.toString(), // Corrected parameter name
      "inTime": "$formattedDate $formattedTime",
      "patientId": patientId.toString(),
    });

    try {
      final response = await http.post(
        Uri.https('blessmate.onrender.com', '/Patient/MakeAppointment'),
        headers: {
          "Content-Type": "application/json", // Set Content-Type header
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print("sucessfully  to make appointment.  ${response.statusCode}");
        // Redirecting the user to the next page after successful booking
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentReviewView(
              date: formattedDate,
              time: formattedTime,
              clinicNumber: widget.clinicNumber, // تمرير رقم العيادة هنا
            ),
          ),
        );
      } else {
        // Print response body for error details
        print("Failed to make appointment. Error code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error making appointment: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
            );

            if (selectedDate != null) {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(DateTime.now()),
              );

              if (selectedTime != null) {
                setState(() {
                  // Formatting the selected date and time
                  this.date = DateFormat("yyyy-M-d hh:mm a").format(DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  ));
                });
              }
            }
          },
          child: HeaderWidget(
            icon: Icons.calendar_month,
            title: "اختر التاريخ".tr,
          ),
        ),
        const SizedBox(height: 12),
        //Text("Therapist ID: ${widget.therapistId}"),
      //  Text("Patient ID: ${widget.patientId}"),
        Text(' الوقت: $date $time'),
        const SizedBox(height: 12),
         Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "يمكن إعادة جدولة هذه الجلسة أو إلغاؤها بعد 24 ساعة قبل الجلسة".tr,
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
          text: "لقد اخترت $date $time".tr,
          width: MediaQuery.of(context).size.width,
          onPressed: (anim) {
            makeAppointment();
          },
        )
      ],
    );
  }
}




class AppointmentReviewView extends StatefulWidget {
  const AppointmentReviewView({
    Key? key,
    required this.date,
    required this.time,
    required this.clinicNumber, // استلام رقم العيادة هنا
  }) : super(key: key);

  final String date;
  final String time;
  final String clinicNumber; // تعريف متغير لتخزين رقم العيادة

  @override
  State<AppointmentReviewView> createState() => _AppointmentReviewViewState();
}

class _AppointmentReviewViewState extends State<AppointmentReviewView> {
  PaymentMethod checkoutPaymentMethod = paymentMethod.first;
  void changeCheckOutPaymentMethod(PaymentMethod? val) {
    setState(() {
      checkoutPaymentMethod = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "ملخص المراجعة".tr,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                         Expanded(
                          child: Text(
                            "التاريخ والساعة".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.date} | ${widget.time}",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                     Divider(),
                     Row(
                      children: [
                        Expanded(
                          child: Text(
                            "المدة".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "30 دقيقه".tr,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "المبلغ".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.clinicNumber ?? ""} جنيها "'.tr, // Ensure widget.clinicNumber is not null
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
               Text(
                "الطريقة المختارة للدفع".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var e = paymentMethod[index];
                    return RadioListTile<PaymentMethod>(
                      contentPadding: EdgeInsets.zero,
                      value: e,
                      activeColor: Colors.cyan,
                      controlAffinity: ListTileControlAffinity.trailing,
                      groupValue: checkoutPaymentMethod,
                      title: Row(
                        children: [
                          Icon(
                            e.icon,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            e.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      onChanged: changeCheckOutPaymentMethod,
                    );
                  },
                  itemCount: paymentMethod.length,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child:AppProgressButton(
                  radius: 8,
                  text: "تأكيد".tr,
                  width: MediaQuery.of(context).size.width,
                  // داخل onPressed للزر
                  onPressed: (anim) async {
                    // بناء الجسم للطلب
                    Map<String, dynamic> requestBody = {
                      "SessionPrice": 50,
                      "Times": 50
                    };

                    // إرسال الطلب POST
                    try {
                      final response = await http.post(
                        Uri.parse('https://blessmate.onrender.com/Manage/CheckOut'),
                        body: jsonEncode(requestBody),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                      );

                      if (response.statusCode == 200) {
                        // الاستجابة ناجحة
                        // قم بفتح الرابط في متصفح الويب
                        await launch(response.body);
                      } else {
                        // حدث خطأ
                        print('Error: ${response.statusCode}');
                        // يمكنك عرض رسالة خطأ للمستخدم هنا
                      }
                    } catch (e) {
                      // حدث استثناء
                      print('Exception: $e');
                      // يمكنك عرض رسالة خطأ للمستخدم هنا
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


