import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:chat_app/application/feature/personalData/friendprofile.dart';
import 'package:chat_app/application/feature/personalData/widget/messagetextfield.dart';
import 'package:chat_app/application/feature/personalData/widget/singlemessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ShowImagesState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendProfile(
                image: friendImage,
                name: friendName,
                email: friendName,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // elevation: 1,
          backgroundColor: Colors.white,
          actions: [
            Row(
              children: [
                DropdownButton<String>(
                  icon: const Icon(Icons.more_vert),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 13, 13, 13)),
                  onChanged: (value) {},
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Clear Data'),
                      value: 'Clear Data',
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: InkWell(
            onTap: () {
              BlocProvider.of<ChatBloc>(context).add(ShowImageEvent());
            },
            child: Row(
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
                  style: const TextStyle(fontSize: 19, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(thickness: 00,),
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
                      .doc(friendId)
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
            MessageTextField(currentUser!.uid, friendId),
            CustomSizedBox(hieght: 6),
          ],
        ),
      ),
    );
  }
}
