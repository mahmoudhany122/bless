import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final bool isUserMessage;

  Message({required this.text, required this.isUserMessage});

  // Convert the Message object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUserMessage': isUserMessage,
    };
  }

  // Factory method to create a Message object from a JSON-compatible Map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] as String,
      isUserMessage: json['isUserMessage'] as bool,
    );
  }
}

class MessageDoc {
  late String text;
  late bool isUserMessage;
  late String senderId;
  late DateTime timestamp;

  MessageDoc({
    required this.text,
    required this.isUserMessage,
    required this.senderId,
    required this.timestamp,
  });

  MessageDoc.fromJson(Map<String, dynamic> json) {
    if (json['text'] != null && json['isUserMessage'] != null) {
      text = json['text'] as String;
      isUserMessage = json['isUserMessage'] as bool;
      senderId = json['email'] as String? ?? '';

      // Convert Firestore Timestamp to DateTime
      timestamp = (json['timestamp'] as Timestamp).toDate();
    } else {
      throw Exception('Invalid message data: $json');
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['isUserMessage'] = isUserMessage;
    data['senderId'] = senderId;
    data['timestamp'] = timestamp; // Add timestamp field
    return data;
  }
}



class HealthCondition {
  final String name;
  final String description;

  HealthCondition({required this.name, required this.description});
}


class User {
  final String firstName;
  final String email;

  User({required this.firstName, required this.email});
}
class UserData {
  final String firstName;
  final String lastName;
  final String email;

  UserData({required this.firstName, required this.lastName, required this.email});
}


