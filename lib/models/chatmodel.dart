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

  MessageDoc({required this.text, required this.isUserMessage, required this.senderId});

  MessageDoc.fromJson(Map<String, dynamic> json) {
    if (json['text'] != null && json['isUserMessage'] != null) {
      text = json['text'] as String;
      isUserMessage = json['isUserMessage'] as bool;
      senderId = json['senderId'] as String? ?? ''; // Provide a default value if senderId is not present
    } else {
      throw Exception('Invalid message data: $json');
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['text'] = text;
    data['isUserMessage'] = isUserMessage;
    data['senderId'] = senderId;
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
