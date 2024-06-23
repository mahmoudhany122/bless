// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widgets/progress_button.dart';
import 'congratulations_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppointmentReviewView extends StatefulWidget {
  const AppointmentReviewView({
    Key? key,
    required this.date,
    required this.time,
  }) : super(key: key);
  final String date;
  final String time;

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
        title: const Text(
          "ملخص المراجعة",
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
                        const Expanded(
                          child: Text(
                            "التاريخ والساعة",
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
                    const Divider(),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "المدة",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                          "30 دقيقه",
                            textAlign: TextAlign.end,
                            style: TextStyle(
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
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "المبلغ",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "350 جنيها ",
                            textAlign: TextAlign.end,
                            style: TextStyle(
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
                            "المده(30دقيقه)",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "1x350 جنيها",
                            textAlign: TextAlign.end,
                            style: TextStyle(
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
                            "المجموع",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "350 جنيها",
                            textAlign: TextAlign.end,
                            style: TextStyle(
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
              const Text(
                "الطريقة المختارة للدفع",
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
                              fontWeight: FontWeight.w500,
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
              const SizedBox(height: 20),
              AppProgressButton(
                radius: 8,
                text: "تأكيد",
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
            ],
          ),
        ),
      ),
    );
  }
}