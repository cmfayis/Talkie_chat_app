import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/application/feature/viedo_call/view/videocall.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  String? body = message.notification!.body;
  String? title = message.notification!.title!.split('1a2b3c4d5e').first;
  String? channelName = message.notification!.title!.split('1a2b3c4d5e').last;
  if (notification != null && android != null) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: const Color(0x0000796a),
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept Call',
            color: Colors.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT',
            label: 'Reject Call',
            color: Colors.red,
            autoDismissible: true,
          ),
        ]);
    AwesomeNotifications().setListeners(onActionReceivedMethod: (action) async {
      if (action.buttonKeyPressed == 'REJECT') {
        Get.snackbar("Rejected", "Call from $body is rejected",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent);
      } else if (action.buttonKeyPressed == 'ACCEPT') {
        await [Permission.camera, Permission.microphone]
            .request()
            .then((value) {
          Get.to(() => VideoCall(channelName: channelName));
        });
      } else {
        print("CLicked on notifications");
      }
    });
  }
}
