import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';

class AudioCall extends StatefulWidget {
  final String channelName;
  final String? name;
  final String? image;

  const AudioCall(
      {Key? key,
      required this.channelName,
      this.name,
       this.image})
      : super(key: key);

  @override
  State<AudioCall> createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {
  late RtcEngine _engine;
  bool muted = false;

  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    _engine = await RtcEngine.createWithContext(
        RtcEngineContext("0ee1091de022492e8446d9a7d3cb4828"));
    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        if (kDebugMode) {
          print("onJoinChannel: $channel, uid: $uid");
        }
      },
      userJoined: (uid, elapsed) {
        print("UserJoined: $uid");
      },
      userOffline: (uid, elapsed) {
        if (kDebugMode) {
          print("Useroffline: $uid");
        }
      },
    ));
    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
                child: Column(
              children: [
                CustomSizedBox(
                  hieght: 65,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.image??'ddd'),
                ),
                CustomSizedBox(
                  hieght: 15,
                ),
                Text(
                  widget.name??'Unknown',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text(" ringing "),
              ],
            )),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              _onToggleMute();
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(5),
            elevation: 2.0,
            fillColor: (muted) ? Colors.blue : Colors.white,
            child: Icon(
              (muted) ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blue,
              size: 40,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _onVideoCallEnd();
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(5),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onVideoCallEnd() {
    _engine.leaveChannel().then((value) {
      Navigator.pop(context);
    });
  }
}
