import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chatmodel.dart';
import 'chat game/video.dart'; // Import the updated MessageDoc class


class ChatScreenDoc extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChatScreenDoc({Key? key, required this.userData}) : super(key: key);

  @override
  _ChatScreenDocState createState() => _ChatScreenDocState();
}

class _ChatScreenDocState extends State<ChatScreenDoc> {
  late FirebaseFirestore _firestore;
  TextEditingController _textEditingController = TextEditingController();
  String _currentMessage = ''; // تخزين النص المكتوب حالياً
  String _email = '';





  @override
  void initState() {
    super.initState();
    _loadUserData();
    _firestore = FirebaseFirestore.instance;
  }
  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
    });
  }
  // دالة تحديث واجهة المستخدم لعرض النص الذي تم كتابته بشكل مستمر
  void updateCurrentMessage(String value) {
    setState(() {
      _currentMessage = value;
    });
  }

  Future<void> sendMessage(String message) async {
    final userMessage = MessageDoc(
      text: message,
      senderId: _email,  // Replace 'currentUserId' with the actual sender's ID
      timestamp: DateTime.now(), // Set the timestamp here
      receiverId: widget.userData["email"],
    );
    try {
      await _firestore.collection('chat').add(userMessage.toJson());
      _textEditingController.clear();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "معالج بليس ميت",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: HexColor('00B4D8')),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => VideoCallScreen(),));
            },
          ),
          IconButton(
            icon: Icon(Icons.call, color: HexColor('00B4D8')),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('chat')
                  .where('senderId', isEqualTo: _email)
                  .where('receiverId', isEqualTo: widget.userData["email"])
                  .orderBy('timestamp')
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final List<MessageDoc> messages = snapshot.data!.docs
                    .map((doc) => MessageDoc.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                // ترتيب الرسائل حسب الوقت الذي تم إرسال الرسالة فيه
                messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: message.senderId ==_email ? Alignment.topRight : Alignment.topLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color:  message.senderId ==_email ? HexColor('00B4D8') : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.senderId ==_email ? Colors.white : Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: updateCurrentMessage, // استدعاء الدالة عندما يتم تغيير النص
                      decoration: InputDecoration(
                        hintText: 'أكتب رسالتك هنا...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: HexColor('00B4D8'),
                  child: IconButton(
                    icon: Icon(Icons.send_outlined, color: Colors.white),
                    onPressed: () {
                      final message = _currentMessage.trim(); // استخدام النص المحفوظ
                      if (message.isNotEmpty) {
                        sendMessage(message);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
