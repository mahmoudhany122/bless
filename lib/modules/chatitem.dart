import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import '../models/chatmodel.dart';
import 'chat_doc.dart'; // Import the updated MessageDoc class

class SCREENMESSENGER extends StatelessWidget {
  const SCREENMESSENGER({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 13),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('chat').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final List<QueryDocumentSnapshot> chatDocuments = snapshot.data!.docs;
                  if (chatDocuments.isEmpty) {
                    return Center(child: Text('No chats available'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: chatDocuments.length,
                    itemBuilder: (context, index) {
                      final chatDoc = chatDocuments[index];
                      final userData = chatDoc.data() as Map<String, dynamic>;
                      return chatItem(context, userData);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatItem(BuildContext context, Map<String, dynamic> userData) {
    return GestureDetector(
      onTap: () {
        // افتح صفحة المحادثة للشخص المحدد
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreenDoc(userData: userData)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/img_12.png"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        userData['lastMessage'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(),
                      Text(
                        userData['lastMessageTime'] ?? '',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.access_time_sharp),
          ],
        ),
      ),
    );
  }
}
