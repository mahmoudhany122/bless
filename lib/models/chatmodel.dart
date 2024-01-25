class Message {
  final text;
  bool isUserMessage;
  String? audioPath;

  Message({this.text, required this.isUserMessage, this.audioPath});
}

class HealthCondition {
  final String name;
  final String description;

  HealthCondition({required this.name, required this.description});
}
