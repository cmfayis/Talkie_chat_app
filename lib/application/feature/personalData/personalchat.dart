import 'package:chat_app/application/feature/personalData/widget/messagetextfield.dart';
import 'package:chat_app/application/feature/personalData/widget/singlemessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String friendId;
  final String friendName;
  final String friendImage;
  ChatPage({
    Key? key,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
  }) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 243, 220, 220),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Image.network(
                friendImage,
                height: 55,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              friendName,
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding:const EdgeInsets.all(10),
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser!.uid)
                    .collection('messages')
                    .doc(friendId)
                    .collection('chats')
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("Say Hi"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics:const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentUser!.uid;
                          return SingleMessage(
                              message: snapshot.data.docs[index]['message'],
                              isMe: isMe);
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField(currentUser!.uid, friendId),
        ],
      ),
    );
  }
}
