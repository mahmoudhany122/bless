import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class VideoCallScreen extends StatefulWidget {
    const VideoCallScreen({super.key});
  
    @override
    State<VideoCallScreen> createState() => _VideoCallScreenState();
  }
  
  class _VideoCallScreenState extends State<VideoCallScreen> {
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

   // now lets create the functions :

//Functions
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
// player.stop();
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

//current User View
    Widget _renderLocalPreview() {
      return RtcLocalView.SurfaceView();
    }
//remote User View

    Widget _renderRemoteVideo() {
      if (_remoteUid != 0) {
        return RtcRemoteView.SurfaceView(
          uid: _remoteUid, channelId: '',
        );
      } else {
        return Text(
        "Callling ..",
        style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
      );
      }
      }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: _renderRemoteVideo(),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: Container(
                      height: 150, width: 150, child: _renderLocalPreview()),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        icon: Icon(
                          Icons.call_end,
                          size: 44,
                          color: Colors.redAccent,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
  class AgoraManager {
    static String get appId {
      return 'a6f068daf319413dae8da3cf4d8545c2';
    }

    static String get token {
      return '007eJxTYAh6pmWqxOzK5Mex8xeHyaTst05f113bt195w7u5mwMdb1UrMCSapRmYWaQkphkbWpoYGqckpgI5xslpJikWpiamyUayJnVpDYGMDIGf5jMyMkAgiM/CkJthaMjAAAAYYB6/';
    }

    static String get channelName {
      return 'mh11';
    }
  }