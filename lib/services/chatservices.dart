import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  Future<String> getBotResponse(String message) async {
    final url = Uri.parse('https://blissmate-chatbot.onrender.com/ChatBot?msg=$message');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final botResponse = responseData['answer'];
      return botResponse;
    } else {
      return 'Please try another word';
    }
  }

  Future<String> getDiseaseInfo(String name) async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/ChatBot/Disease?name=$name');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final diseaseInfo = responseData['info'];
        return diseaseInfo;
      } else {
        return 'Failed to fetch disease information. Status code: ${response.statusCode}';
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }
}
