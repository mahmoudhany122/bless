import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart' as rx; // تحديد prefix لمكتبة rxdart
import '../models/chatmodel.dart'; // استيراد نموذج MessageDoc المحدث
import 'chat game/video.dart'; // استيراد VideoCallScreen المحدثة

class ChatScreenDoc extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChatScreenDoc({Key? key, required this.userData}) : super(key: key);

  @override
  _ChatScreenDocState createState() => _ChatScreenDocState();
}

class _ChatScreenDocState extends State<ChatScreenDoc> {
  late FirebaseFirestore _firestore;
  TextEditingController _textEditingController = TextEditingController();
  String _currentMessage = '';
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

  void updateCurrentMessage(String value) {
    setState(() {
      _currentMessage = value;
    });
  }

  Future<void> sendMessage(String message) async {
    final userMessage = MessageDoc(
      text: message,
      senderId: _email,
      timestamp: DateTime.now(),
      receiverId: widget.userData["email"],
    );
    try {
      await _firestore.collection('chat').add(userMessage.toJson());
      _textEditingController.clear();
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  Stream<List<MessageDoc>> getMessages() {
    Stream<QuerySnapshot> sentMessagesStream = _firestore
        .collection('chat')
        .where('senderId', isEqualTo: _email)
        .where('receiverId', isEqualTo: widget.userData["email"])
        .orderBy('timestamp')
        .snapshots();

    Stream<QuerySnapshot> receivedMessagesStream = _firestore
        .collection('chat')
        .where('senderId', isEqualTo: widget.userData["email"])
        .where('receiverId', isEqualTo: _email)
        .orderBy('timestamp')
        .snapshots();

    return rx.Rx.combineLatest2(sentMessagesStream, receivedMessagesStream, (QuerySnapshot sent, QuerySnapshot received) {
      List<MessageDoc> messages = [];
      messages.addAll(sent.docs.map((doc) => MessageDoc.fromJson(doc.data() as Map<String, dynamic>)).toList());
      messages.addAll(received.docs.map((doc) => MessageDoc.fromJson(doc.data() as Map<String, dynamic>)).toList());
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "معالج بليس ميت".tr,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: HexColor('00B4D8')),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCallScreen(),));
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
            child: StreamBuilder<List<MessageDoc>>(
              stream: getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final List<MessageDoc> messages = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: message.senderId == _email ? Alignment.topRight : Alignment.topLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: message.senderId == _email ? HexColor('00B4D8') : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.senderId == _email ? Colors.white : Colors.black,
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
                      onChanged: updateCurrentMessage,
                      decoration: InputDecoration(
                        hintText: 'أكتب رسالتك هنا...'.tr,
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
                      final message = _currentMessage.trim();
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
