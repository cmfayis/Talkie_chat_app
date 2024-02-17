import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/personalData/widget/messagetextfield.dart';
import 'package:chat_app/application/feature/personalData/widget/singlemessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor:Color(0xffADD8E6),
        actions: const [
          Row(
            children: [
              Icon(Icons.more_vert),
              SizedBox(
                width: 15,
              ),
            ],
          )
        ],
        // toolbarHeight: 80,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              radius: 21,
              backgroundImage: NetworkImage(friendImage),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              friendName,
              style: const TextStyle(
                  fontSize: 19,
                  
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
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
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentUser!.uid;
                          final data = snapshot.data.docs[index];
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(currentUser?.uid)
                                  .collection('messages')
                                  .doc(friendId)
                                  .collection('chats')
                                  .doc(data.id)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(friendId)
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
                                isMe: isMe),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField(currentUser!.uid, friendId),
          const CustomSizedBox(
            hieght: 6,
          ),
        ],
      ),
    );
  }
}
