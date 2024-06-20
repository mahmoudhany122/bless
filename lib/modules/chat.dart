import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chatmodel.dart';
import '../services/chatservices.dart';
import 'package:http/http.dart'as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();
  List<Message> messages = [];
  bool isLoading = false;
  final ChatService chatService = ChatService();
  TextEditingController _textEditingController = TextEditingController();
  late String _filePath;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isPlayer =false;
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  @override
  void initState() {
    super.initState();
    _loadMessages();// استرجاع الرسائل عند بدء بناء الشاشة
    _requestPermission();
    openTheRecorder();
  }
  void dispose(){
    super.dispose();
    _audioRecorder.closeRecorder();
  }
  // تحميل الرسائل المحفوظة في الذاكرة المحلية
  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('chat_messages');

    if (savedMessages != null) {
      setState(() {
        messages = savedMessages.map((msg) =>
            Message.fromJson(msg as Map<String, dynamic>)).toList();
      });
    }
  }

  // حفظ الرسالة المرسلة في الذاكرة المحلية
  Future<void> _saveMessage(Message message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedMessages =
    messages.map((msg) => msg.toJson()).toList()
        .map((e) => e.toString())
        .toList();
    prefs.setStringList('chat_messages', savedMessages);
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      isLoading = true;
    });

    final userMessage = Message(
        text: message, isUserMessage: true, audio: _filePath);
    final sendingMessage = Message(
        text: '.....', isUserMessage: false, audio: _filePath);

    setState(() {
      messages.add(userMessage);
      messages.add(sendingMessage);
    });

    // Delay the response by 2 seconds
    await Future.delayed(Duration(seconds: 3));

    try {
      final botResponse = await chatService.getBotResponse(message);

      if (message != null && message != botResponse) {
        final updatedSendingMessage =
        Message(text: botResponse, isUserMessage: false, audio: _filePath);

        setState(() {
          messages.remove(sendingMessage);
          messages.add(updatedSendingMessage);
          isLoading = false;
        });
      } else {
        setState(() {
          messages.remove(sendingMessage);
          messages.add(Message(
              text: 'لا يوجد اجابه حاول مره اخرى'.tr,
              isUserMessage: false,
              audio: _filePath));
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.remove(sendingMessage);
        messages.add(Message(text: 'خطا فى صيغه السؤال'.tr,
            isUserMessage: false,
            audio: _filePath));
      });
    }

    _saveMessage(userMessage); // حفظ الرسالة المرسلة
  }

  void _requestPermission() async{
    var status = await Permission.microphone.request();
    if(!status.isGranted){
      throw Exception("Microphone Permission not granted");
    }
    if(await Permission.storage.isDenied){
      await Permission.storage.request();
    }
  }
  Future<void> openTheRecorder() async{
    await _audioRecorder.openRecorder();
  }

  Future<String?> _startRecording() async {
    String path = await _getFilePath();
    await _audioRecorder.openRecorder();
    await _audioRecorder.startRecorder(toFile: path,codec: Codec.pcm16WAV);
    try {

      setState(() {
        _isRecording = true;
        _filePath = path;
      });
      return path;

    } catch (e) {
      print("Error starting recording: $e");
      return null;
    }
  }

  Future<void> _stopRecording() async {
    try{
      await _audioRecorder.stopRecorder();
      await _audioRecorder.closeRecorder();
      setState(() {
        _isRecording = false;
      });
      print('Stop recrder. File saved at : $_filePath');
    }
    catch(e){
      print("error stopping recording : $e");
    }

    _uploadFile();

  }
  Future<String> _getFilePath()async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    String _filePath= "$appDirPath/recrding_${DateTime.now().microsecondsSinceEpoch}.wav";
    return _filePath;
  }

  Future<void> _uploadFile() async {
    if (_filePath != null) {
      File audioFile = File(_filePath);
      String apiUrl = 'https://blissmate-chatbot.onrender.com/ChatBot/Record';

      try {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(http.MultipartFile(
          'audio',
          audioFile.readAsBytes().asStream(),
          audioFile.lengthSync(),
          filename: basename(audioFile.path),
        ));
        var response = await request.send();

        // Check the response status
        if (response.statusCode == 200) {
          // File uploaded successfully
          print('File uploaded successfully!');
        } else {
          // Handle error
          print('Failed to upload file. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle network errors
        print('Error: $error');
      }

    }
  }

  play(_filePath)async{
    await _audioRecorder.openRecorder();
    setState(() {
      _isPlayer=true;
    });
    print('audio player');
  }
  stop()async{
    await _audioRecorder.stopRecorder();
    setState(() {
      _isPlayer=false;
    });
    print('stop audio');
  }


  String _selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 75,
            ),
            Text(
              "معالج بليس ميت".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              width: 15,
            ),
            Image(
              image: AssetImage(
                "assets/images/img_10.png",
              ),
              height: 30,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:ListView.builder(
              controller: _controller,
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];

                // Check if the message is a text message
                if (message.text != null && message.text.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: message.isUserMessage
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: message.isUserMessage
                            ? HexColor('00B4D8')
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            color: message.isUserMessage
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                // Check if the message is an audio message
                else if (message.audio != null && message.audio.isNotEmpty) {
                  // Replace 'BubbleNormalAudio' with your own widget for displaying audio messages
                  return BubbleNormalAudio(
                      color: HexColor('00B4D8'),
                      onSeekChanged: (e){},
                      isLoading: false,
                      isPlaying: _isPlayer,
                      onPlayPauseButtonClick: () {
                        if (!_isPlayer) {
                          play(message.audio);
                        } else {stop();}
                      }
                  );
                }

                return SizedBox(); // Return an empty SizedBox for other types of messages
              },
            ),


          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Directionality(
              textDirection:
              _selectedLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HexColor('00B4D8'),
                    child: IconButton(
                      icon:_isRecording?
                      Icon(Icons.stop,color: Colors.white,): Icon(Icons.mic,color: Colors.white,),
                      onPressed: () {
                        if(!_isRecording){
                          _startRecording();
                        }else{
                          _stopRecording();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    height: 60,
                    width: 250,
                    child: Center(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: '...أكتب رسالتك هنا'.tr,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HexColor('00B4D8'),
                    child: IconButton(
                      icon: Icon(
                        Icons.cleaning_services, // أيقونة المكنسة
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // عند الضغط على الزرار، عرض مربع حوار لتأكيد مسح محتويات الشات
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("تأكيد مسح المحادثة"),
                              content: Text("هل تريد بالفعل مسح محتويات الشات؟"),
                              actions: <Widget>[
                                // زر للتأكيد
                                TextButton(
                                  child: Text("نعم"),
                                  onPressed: () {
                                    // قم بمسح محتويات الشات وإغلاق مربع الحوار
                                    setState(() {
                                      messages.clear(); // مسح جميع الرسائل
                                    });
                                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                                  },
                                ),
                                // زر للإلغاء
                                TextButton(
                                  child: Text("لا"),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // إغلاق مربع الحوار
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: HexColor('00B4D8'),
                    child: IconButton(
                      icon: Icon(Icons.send_outlined, color: Colors.white),
                      onPressed: () {
                        final message = _textEditingController.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(message);
                          _textEditingController.clear();
                          _controller.animateTo(
                              _controller.position.minScrollExtent,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeIn);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
