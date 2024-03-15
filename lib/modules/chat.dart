import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chatmodel.dart';
import '../services/chatservices.dart';
import 'dart:convert';
import '../models/chatmodel.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  bool isLoading = false;
  final ChatService chatService = ChatService();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages(); // استرجاع الرسائل عند بدء بناء الشاشة
  }

  // تحميل الرسائل المحفوظة في الذاكرة المحلية
  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('chat_messages');

    if (savedMessages != null) {
      setState(() {
        messages = savedMessages.map((msg) => Message.fromJson(msg as Map<String, dynamic>)).toList();
      });
    }
  }

  // حفظ الرسالة المرسلة في الذاكرة المحلية
  Future<void> _saveMessage(Message message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedMessages =
    messages.map((msg) => msg.toJson()).toList().map((e) => e.toString()).toList();
    prefs.setStringList('chat_messages', savedMessages);
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      isLoading = true;
    });

    final userMessage = Message(text: message, isUserMessage: true);
    final sendingMessage = Message(text: '.....', isUserMessage: false);

    setState(() {
      messages.add(userMessage);
      messages.add(sendingMessage);
    });

    // Delay the response by 2 seconds
    await Future.delayed(Duration(seconds: 3));

    try {
      final botResponse = await chatService.getBotResponse(message);

      if (message != null && message != botResponse) {
        final updatedSendingMessage =
        Message(text: botResponse, isUserMessage: false);

        setState(() {
          messages.remove(sendingMessage);
          messages.add(updatedSendingMessage);
          isLoading = false;
        });
      } else {
        setState(() {
          messages.remove(sendingMessage);
          messages.add(Message(
              text: 'لا يوجد اجابه حاول مره اخرى'.tr, isUserMessage: false));
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.remove(sendingMessage);
        messages.add(Message(text: 'خطا فى صيغه السؤال'.tr, isUserMessage: false));
      });
    }

    _saveMessage(userMessage); // حفظ الرسالة المرسلة
  }

  String _selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 75,
            ),
            Text(
              "معالج بليس ميت".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              width: 15,
            ),
            Image(
              image: AssetImage(
                "assets/images/img_10.png",
              ),
              height: 30,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: message.isUserMessage
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: message.isUserMessage
                          ? HexColor('00B4D8')
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUserMessage
                              ? Colors.white
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Directionality(
              textDirection:
              _selectedLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 280,
                    child: Center(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: '...أكتب رسالتك هنا'.tr,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HexColor('00B4D8'),
                    child: IconButton(
                      icon: Icon(
                        Icons.cleaning_services, // أيقونة المكنسة
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // عند الضغط على الزرار، عرض مربع حوار لتأكيد مسح محتويات الشات
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("تأكيد مسح المحادثة"),
                              content: Text("هل تريد بالفعل مسح محتويات الشات؟"),
                              actions: <Widget>[
                                // زر للتأكيد
                                TextButton(
                                  child: Text("نعم"),
                                  onPressed: () {
                                    // قم بمسح محتويات الشات وإغلاق مربع الحوار
                                    setState(() {
                                      messages.clear(); // مسح جميع الرسائل
                                    });
                                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                                  },
                                ),
                                // زر للإلغاء
                                TextButton(
                                  child: Text("لا"),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HexColor('00B4D8'),
                    child: IconButton(
                      icon: Icon(Icons.send_outlined, color: Colors.white),
                      onPressed: () {
                        final message = _textEditingController.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(message);
                          _textEditingController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}


