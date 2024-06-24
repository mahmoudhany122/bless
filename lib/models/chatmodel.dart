import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final bool isUserMessage;
  final String audio;

  Message({required this.text, required this.isUserMessage,required this.audio});

  // Convert the Message object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUserMessage': isUserMessage,
      "audio" : audio
    };
  }

  // Factory method to create a Message object from a JSON-compatible Map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] as String,
      isUserMessage: json['isUserMessage'] as bool,
      audio: json['audio'] as String,
    );
  }
}

class MessageDoc {
  late String text; // نص الرسالة
  late String senderId; // معرف المرسل
  late DateTime timestamp; // الوقت الذي تم فيه إرسال الرسالة
  late String receiverId; // معرف المستقبل


  MessageDoc({
    required this.text,
    required this.senderId,
    required this.timestamp,
    required this.receiverId,
  });

  // محول لتحويل البيانات من صيغة JSON إلى صيغة MessageDoc
  MessageDoc.fromJson(Map<String, dynamic> json) {
    if (json['text'] != null) {
      text = json['text'] as String;
      senderId = json['senderId'] as String? ?? ''; // تم تعديل هذا السطر ليتوافق مع البيانات المتوقعة
      receiverId = json['receiverId'] as String? ?? ''; // إضافة استقبال معرف المستلم من JSON
      // تحويل الطابع الزمني من Firestore Timestamp إلى DateTime
      timestamp = (json['timestamp'] as Timestamp).toDate();
    } else {
      throw Exception('Invalid message data: $json');
    }
  }

  // محول لتحويل البيانات من صيغة MessageDoc إلى JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['senderId'] = senderId;
    data['timestamp'] = timestamp; // إضافة الطابع الزمني
    data['receiverId'] = receiverId; // إضافة معرف المستلم
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