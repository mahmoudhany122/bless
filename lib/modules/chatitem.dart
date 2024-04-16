import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SCREENMESSENGER extends StatefulWidget {
  @override
  _SCREENMESSENGERState createState() => _SCREENMESSENGERState();
}

class _SCREENMESSENGERState extends State<SCREENMESSENGER> {
  late String _email;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where('receiverId', isEqualTo: _email)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<DocumentSnapshot> messages = snapshot.data!.docs;
          Set<String> displayedEmails = {}; // تخزين الأيميلات التي تم عرضها بالفعل
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final senderId = message['senderId'];
              if (!displayedEmails.contains(senderId)) {
                displayedEmails.add(senderId);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationScreen(
                          senderId: senderId,
                          email: _email,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      senderId,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink(); // عدم عرض الايميل إذا تم عرضه بالفعل
              }
            },
          );
        },
      ),
    );
  }
}

class ConversationScreen extends StatefulWidget {
  final String senderId;
  final String email;

  ConversationScreen({required this.senderId, required this.email});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late TextEditingController _textEditingController;
  late String _currentMessage;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _currentMessage = '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void updateCurrentMessage(String text) {
    setState(() {
      _currentMessage = text;
    });
  }

  void sendMessage(String message) {
    // هنا يمكنك إرسال الرسالة إلى قاعدة البيانات
    // يمكنك استخدام FirebaseFirestore.instance.collection('chat').add() لإضافة الرسالة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .where('senderId', isEqualTo: widget.senderId)
                  .where('receiverId', isEqualTo: widget.email)
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final List<DocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['senderId'] == widget.email;
                    return Align(
                      alignment: isMe ?  Alignment.topRight : Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? HexColor('00B4D8') : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          message['text'] ?? 'No message',
                          style: TextStyle(color: isMe ?  Colors.white : Colors.black,),
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
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.send),
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
