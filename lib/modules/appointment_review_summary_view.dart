// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widgets/progress_button.dart';
import 'congratulations_dialog.dart';

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
          "Review Summary",
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
                            "Date & Hour",
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
                            "Duration",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "30 minutes",
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
                            "amount",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "350 LE",
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
                            "Duration(30mins)",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "1x350 LE",
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
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "350 LE",
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
                "The chosen payment method",
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
                text: "Confirm",
                width: MediaQuery.of(context).size.width,
                onPressed: (anim) {
                  showDialog(
                    context: context,
                    builder: (context) => const CongratulationsDialog(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}