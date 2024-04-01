import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/application/feature/personalData/widget/notification.dart';
import 'package:chat_app/application/feature/viedo_call/view/videocall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:chat_app/application/feature/personalData/friendprofile.dart';
import 'package:chat_app/application/feature/personalData/widget/messagetextfield.dart';
import 'package:chat_app/application/feature/personalData/widget/singlemessage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatefulWidget {
  final String friendId;
  final String friendName;
  final String friendImage;
  final String token;

  ChatPage({
    Key? key,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.token,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  void updateFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .update({'token': token});
    } catch (e) {
      print('Error updating FCM token: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    updateFcmToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String? body = message.notification!.body;
      String? title = message.notification!.title!.split('1a2b3c4d5e').first;
      String? channelName =
          message.notification!.title!.split('1a2b3c4d5e').last;
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
              backgroundColor: const Color(0x00796a),
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
        AwesomeNotifications().setListeners(
            onActionReceivedMethod: (action) async {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ShowImagesState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendProfile(
                image: widget.friendImage,
                name: widget.friendName,
                email: widget.friendName,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // elevation: 1,
          toolbarHeight: 70,
          backgroundColor: Color.fromARGB(255, 9, 48, 79),
          actions: [
            IconButton(
                onPressed: () {
                  sendPushNotification1(
                      widget.token, widget.friendName, widget.friendImage);
                },
                icon: Icon(
                  CupertinoIcons.phone_circle_fill,
                  color: Colors.white,
                  size: 32,
                )),
            IconButton(
                onPressed: () {
                  sendPushNotification(widget.token, widget.friendName);
                },
                icon: Icon(
                  size: 30,
                  CupertinoIcons.videocam_circle_fill,
                  color: Colors.white,
                ))
          ],
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: InkWell(
            onTap: () {
              BlocProvider.of<ChatBloc>(context).add(ShowImageEvent());
            },
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(widget.friendImage),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.friendName,
                  style: const TextStyle(fontSize: 19, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(
              thickness: 00,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser!.uid)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length < 1) {
                        return Center(
                          child: Text("Say Hi"),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentUser!.uid;
                          final data = snapshot.data.docs[index];
                          return Dismissible(
                            background: Container(
                              height: 10,
                              color: Colors.red,
                              child: Icon(Icons.delete),
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(currentUser?.uid)
                                  .collection('messages')
                                  .doc(widget.friendId)
                                  .collection('chats')
                                  .doc(data.id)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.friendId)
                                  .collection('messages')
                                  .doc(currentUser?.uid)
                                  .collection('chats')
                                  .doc(data.id)
                                  .delete();
                            },
                            child: SingleMessage(
                              type: snapshot.data.docs[index]['type'],
                              currentTime: data['date'],
                              message: snapshot.data.docs[index]['message'],
                              isMe: isMe,
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            MessageTextField(currentUser!.uid, widget.friendId),
            CustomSizedBox(hieght: 6),
          ],
        ),
      ),
    );
  }

  Future<void> sendPushNotification(String token, String name) async {
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
        await [Permission.camera, Permission.microphone]
            .request()
            .then((value) {
          Get.to(() => VideoCall(channelName: channelName));
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
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
