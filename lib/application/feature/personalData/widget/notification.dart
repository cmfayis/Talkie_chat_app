import 'dart:convert';
import 'dart:math';

import 'package:chat_app/application/feature/audio_call/view/audiocall.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

Future<void> sendPushNotification1(
    String token, String name, String image) async {
  String channelName = generateRandomString(8);
  String title = "Incoming Call1a2b3c4d5e$channelName";

  try {
    http.Response response = await http
        .post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAZnn7JRE:APA91bE79MleqbBsTa8EX51lhXUxUnCoQ2pMBQzVlNEKEu_QD9pzQ_QHHiu61HhkDzgiLirfiTeTuMyaMQx7-bUmoGXVEpmcEVwl1VpETV0mAqkfX4yuK0OqDvOSLHYWGCtmt_Xmbv1h',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': name,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': token,
        },
      ),
    )
        .whenComplete(() async {
      await [Permission.microphone].request().then((value) {
        Get.to(() => AudioCall(
              channelName: channelName,
              name: name,
              image: image,
            ));
      });
    });
    response;
  } catch (e) {
    print("Error: ${e.toString()}");
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
