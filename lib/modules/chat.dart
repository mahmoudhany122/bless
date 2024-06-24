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
  String audio = "";
  bool isLoading = false;
  final ChatService chatService = ChatService();
  TextEditingController _textEditingController = TextEditingController();
  late String _filePath;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isPlayer = false;
  bool isPause = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecorderOpen = false;

  @override
  void initState() {
    super.initState();
    _loadMessages(); // Load saved messages
    _requestPermission();
    openTheRecorder();

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlayer = false;
        isPause = false;
        position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('chat_messages');

    if (savedMessages != null) {
      setState(() {
        messages = savedMessages.map((msg) => Message.fromJson(msg as Map<String, dynamic>)).toList();
      });
    }
  }

  Future<void> _saveMessage(Message message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedMessages = messages.map((msg) => msg.toJson()).toList().map((e) => e.toString()).toList();
    prefs.setStringList('chat_messages', savedMessages);
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      isLoading = true;
    });

    final userMessage = Message(text: message, isUserMessage: true, audio: _filePath);
    final sendingMessage = Message(text: '.....', isUserMessage: false, audio: _filePath);

    setState(() {
      messages.add(userMessage);
      messages.add(sendingMessage);
    });

    await Future.delayed(Duration(seconds: 3));

    try {
      final botResponse = await chatService.getBotResponse(message);

      if (message != null && message != botResponse) {
        final updatedSendingMessage = Message(text: botResponse, isUserMessage: false, audio: _filePath);

        setState(() {
          messages.remove(sendingMessage);
          messages.add(updatedSendingMessage);
          isLoading = false;
        });
      } else {
        setState(() {
          messages.remove(sendingMessage);
          messages.add(Message(text: 'لا يوجد اجابه حاول مره اخرى'.tr, isUserMessage: false, audio: _filePath));
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        messages.remove(sendingMessage);
        messages.add(Message(text: 'خطا فى صيغه السؤال'.tr, isUserMessage: false, audio: _filePath));
      });
    }

    _saveMessage(userMessage); // Save sent message
  }

  void _requestPermission() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception("Microphone Permission not granted");
    }
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<void> openTheRecorder() async {
    if (!_isRecorderOpen) {
      await _audioRecorder.openRecorder();
      _isRecorderOpen = true;
    }
  }

  Future<String?> _startRecording() async {
    String path = await _getFilePath();
    if (!_audioRecorder.isRecording) {
      await _audioRecorder.startRecorder(toFile: path, codec: Codec.pcm16WAV);
      setState(() {
        _isRecording = true;
        _filePath = path;
      });
      return path;
    }
    return null;
  }

  Future<void> _stopRecording() async {
    if (_audioRecorder.isRecording) {
      await _audioRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      print('Stop recorder. File saved at: $_filePath');
      _uploadFile();
    }
  }

  Future<String> _getFilePath() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    String filePath = "$appDirPath/recording${DateTime.now().microsecondsSinceEpoch}.wav";
    return filePath;
  }

  Future<void> _uploadFile() async {
    if (_filePath != null) {
      File audioFile = File(_filePath);
      String apiUrl = 'https://blissmate-chatbot.onrender.com/ChatBot/Record';

      try {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(http.MultipartFile(
          'Record',
          audioFile.readAsBytes().asStream(),
          audioFile.lengthSync(),
          filename: basename(audioFile.path),
        ));
        var response = await request.send();

        if (response.statusCode == 200) {
          print('File uploaded successfully!');
        } else {
          print('Failed to upload file. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
      }
    }
    sendMessage(audio);
  }

  play(_filePath) async {
    await _audioPlayer.play(UrlSource(_filePath));
    setState(() {
      _isPlayer = true;
      isPause = false;
    });
    print('audio player');
  }

  stop() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlayer = false;
      isPause = true;
    });
    print('stop audio');
  }

  void resume() async {
    await _audioPlayer.resume();
    setState(() {
      _isPlayer = true;
      isPause = false;
    });
  }

  void seek(double seconds) {
    _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  String _selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "معالج Bliss Mate".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 15),
            Image(
              image: AssetImage("assets/images/img_45.png"),
              height: 42,
              width: 42,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];

                if (message.text != null && message.text.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: message.isUserMessage ? Alignment.topRight : Alignment.topLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: message.isUserMessage ? HexColor('00B4D8') : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            color: message.isUserMessage ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (message.audio != null && message.audio.isNotEmpty) {
                  return BubbleNormalAudio(
                    color: HexColor('00B4D8'),
                    isLoading: false,
                    isPlaying: _isPlayer,
                    duration: duration.inSeconds.toDouble(),
                    position: position.inSeconds.toDouble(),
                    isPause: isPause,
                    onPlayPauseButtonClick: () {
                      if (!_isPlayer) {
                        play(message.audio);
                      } else if (isPause) {
                        resume();
                      } else {
                        stop();
                      }
                    },
                    onSeekChanged: (double seconds) {
                      seek(seconds);
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          if (isLoading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا '.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: HexColor('00B4D8'),
                  child: IconButton(
                    icon: Icon(Icons.send_rounded, color: Colors.white),
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



                IconButton(
                  icon: Icon(_isRecording ? (Icons.stop)  : Icons.mic),
                  color:HexColor('00B4D8'),
                  onPressed: () async {
                    if (_isRecording) {
                      await _stopRecording();
                    } else {
                      await _startRecording();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
