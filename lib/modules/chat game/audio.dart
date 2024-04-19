import "package:agora_rtc_engine/rtc_engine.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:permission_handler/permission_handler.dart";

class AudioCallScreen extends StatefulWidget {
  const AudioCallScreen({Key? key}) : super(key: key);

  @override
  _AudioCallScreenState createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  late int _remoteUid = 0;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black87,
            child: Center(
              child: _remoteUid == 0
                  ? Text(
                "Calling..",
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Calling with $_remoteUid',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Container(
                height: 50,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _endCall(); // تم تحسين تصميم الزر
                      },
                      icon: Icon(
                        Icons.call_end,
                        size: 44,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('local user $uid joined successfully');
        },
        userJoined: (int uid, int elapsed) {
          print('remote user $uid joined successfully');
          setState(() => _remoteUid = uid);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('remote user $uid left call');
          setState(() => _remoteUid = 0);
          Navigator.of(context).pop(true);
        },
      ),
    );
    await _engine.joinChannel(
        AgoraManager.token, AgoraManager.channelName, null, 0);
  }

  void _endCall() {
    Navigator.of(context).pop(true);
  }
}
class AgoraManager {
  static String get appId {
    return 'a6f068daf319413dae8da3cf4d8545c2';
  }

  static String get token {
    return '007eJxTYDi259YFlphdFtZvL5VdDuk8vUhG736EhuWmhzNsWZfGaq5VYEg0SzMws0hJTDM2tDQxNE5JTAVyjJPTTFIsTE1Mk40OflJKawhkZHCxf8zEyACBID4LQ26GoREDAwCqbiAb';
  }

  static String get channelName {
    return 'mh12';
  }
}