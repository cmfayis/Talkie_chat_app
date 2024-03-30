// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/application/feature/SearchFolder/search.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/personalData/personalchat.dart';
import 'package:chat_app/application/feature/personalData/widget/showimage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class chats extends StatefulWidget {
  chats({
    Key? key,
  }) : super(key: key);

  @override
  State<chats> createState() => _ChatState();
}

class _ChatState extends State<chats> with WidgetsBindingObserver {
  User? user = FirebaseAuth.instance.currentUser;
  void updateFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print(token);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update({'token': token});
    } catch (e) {
      print('Error updating FCM token: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    updateFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 9, 48, 79),
        toolbarHeight: 90,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Chats',
            style: TextStyle(fontSize: 27, color: Colors.white),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Search()));
            },
            child: Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.all(2),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                )),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Text(
          //     'Chats',
          //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          //   ),
          // ),
          const CustomSizedBox(
            hieght: 15,
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .collection('messages')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("No Chats Available !"),
                      );
                    }
                    return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 00,
                            indent: 85,
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var friendId = snapshot.data.docs[index].id;
                          var lastMsg = snapshot.data.docs[index]['last_msg'];
                          final time = snapshot.data.docs[index]['Time'];
                          DateTime dateTime = time.toDate();
                          String formattedTime =
                              DateFormat("hh:mm a").format(dateTime);

                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(friendId)
                                .snapshots(),
                            builder: (context, AsyncSnapshot asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                var friend = asyncSnapshot.data;
                                return ListTile(
                                  leading: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ShowImage(
                                                  imageUrl: friend['image'])));
                                    },
                                    child: CircleAvatar(
                                      radius: 29,
                                      backgroundImage:
                                          NetworkImage(friend['image']),
                                    ),
                                  ),
                                  trailing: Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'sans-serif',
                                    ),
                                  ),
                                  title: Text(
                                    friend['Name'],
                                    style: const TextStyle(
                                        fontFamily: 'sans-serif',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  subtitle: lastMsg == 'Photo'
                                      ? Row(
                                          children: [
                                            Icon(Ionicons.camera),
                                            CustomSizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              'photo',
                                              style: TextStyle(
                                                fontFamily: 'sans-serif',
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(
                                          child: Text(
                                            lastMsg,
                                            style: const TextStyle(
                                                fontFamily: 'sans-serif',
                                                color: Color.fromARGB(
                                                    255, 133, 133, 133)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage(
                                                  friendId: friend['uid'],
                                                  friendName: friend['Name'],
                                                  friendImage: friend['image'],
                                                  token: friend['token'],
                                                )));
                                  },
                                );
                              }
                              return Container();
                            },
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
