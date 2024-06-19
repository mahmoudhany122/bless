import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat game/audio.dart';
import 'chat game/video.dart';

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

  String extractUsername(String email) {
    // Split email based on '@' symbol
    List<String> parts = email.split('@');
    // Return the first part (username)
    return parts[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages',
        style: Theme.of(context).textTheme.bodyText1),
        centerTitle: true,
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
          Set<String> displayedEmails = {}; // Store emails that have already been displayed
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
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
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  extractUsername(senderId) ?? 'No username',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/avatar.png'), // Replace with your image
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                );
              } else {
                return SizedBox.shrink(); // Do not display the email if it has already been displayed
              }
            },
          );
        },
      ),
    );
  }
}

// ConversationScreen remains the same...


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
    // Here you can send the message to the database
    // You can use FirebaseFirestore.instance.collection('chat').add() to add the message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation'),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: HexColor('00B4D8')),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => VideoCallScreen(),));
            },
          ),
          IconButton(
            icon: Icon(Icons.call, color: HexColor('00B4D8')),
            onPressed: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AudioCallScreen(),));
            },
          ),
        ],

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
