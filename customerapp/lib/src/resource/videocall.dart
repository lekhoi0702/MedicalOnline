import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../api/get_token.dart';

class VideoCallScreen extends StatefulWidget {
  final int maLH;

  const VideoCallScreen({Key? key, required this.maLH}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Map<String, dynamic>? agora;
  late String channelName = 'test';
  late String token = '007eJxTYPDriQiz+TnPUEiqZ8K++JN5bjknjALXP38UuOHooquJHVsVGCyMEk2NDE2NLS2MjEySLYwtkpONUkySzAxNDZJSLQ1T10vfSWkIZGRQDWliZGSAQBCfhaEktbiEgQEATHsfWQ==';
  late int uid = userData?['id'];

  late final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "82a5215398224c838cc2d4b6150be91e",
      channelName: channelName,
      uid: uid,
      tempToken: token,
    ),
  );

  @override
  void initState() {
    super.initState();
   // _getVideo();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  void dispose() async {
    await client.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
              ),
              AgoraVideoButtons(
                client: client,
              ),
            ],
          ),
        ),
      ),
    );
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
        initAgora();
      });
      print('lich hen : $response ');
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }
}
