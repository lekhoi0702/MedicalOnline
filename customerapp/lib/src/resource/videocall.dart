import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../main.dart';
import 'api/get_token.dart';




const String appId = "82a5215398224c838cc2d4b6150be91e";


class VideoCallScreen extends StatefulWidget {
  final int maLH;
  const VideoCallScreen({Key? key, required this.maLH}) : super(key: key);

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Map<String,dynamic>? agora;
  String channelName = '';
  String token = '';

  int uid = userData?['id']; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
  = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }


  @override
  void initState() {
    super.initState();
    _getVideo();
    // Set up an instance of Agora engine
    setupVideoSDKEngine();
  }

  // Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }



  // Build UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Stack(
                  children: [
                    //Container for the Remote video
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Center(child: _remoteVideo()),
                    ),
                    // Container for the local video (aligned to the top right)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(child: _localPreview()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            // Button Row
            Row(
              children: <Widget>[
                Expanded(
                    child:IconButton(
                      onPressed: _isJoined ? null : () => join(),
                      icon: Icon(
                        Icons.camera_alt, // Replace with your desired camera icon
                        color: Colors.blue,
                      ),
                      color: Colors.blue,
                      // Change to your desired background color for the button
                    )
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: IconButton(
                    onPressed: _isJoined ? () => {leave()} : null,
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            // Button Row ends
          ],
        ),
      ),
    );
  }

// Display local video preview
  Widget _localPreview() {
    if (_isJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (_isJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: appId
    ));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }


  void  join() async {
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }
  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  void _getVideo() async {
    int malh = widget.maLH;
    try {
      dynamic response =
      await ApiServiceGetVideoCall.get_video(malh);
      setState(() {
        agora = response;
        channelName = agora!['channelName'];
        token = agora!['token'];
      });
        print('lich hen : $response ');
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }








}