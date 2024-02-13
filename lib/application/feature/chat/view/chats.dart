// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/application/feature/SearchFolder/search.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/personalData/personalchat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class chats extends StatefulWidget {
  chats({
    Key? key,
  }) : super(key: key);

  @override
  State<chats> createState() => _ChatState();
}

class _ChatState extends State<chats>with WidgetsBindingObserver {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online",);
  }
  void setStatus(String status)async{
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'status':status
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state ==AppLifecycleState.resumed){
      setStatus('Online');
    }else{
      setStatus("Ofline",);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black ,
        toolbarHeight: 90,
        title: const Text(
          'Chat App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.chat,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Search()));
          }),
      backgroundColor: Colors.white,
      body: Column(
        children: [
       const   CustomSizedBox(hieght: 10,),
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
                          return const CustomSizedBox(
                            hieght: 5,
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var friendId = snapshot.data.docs[index].id;
                          var lastMsg = snapshot.data.docs[index]['last_msg'];
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(friendId)
                                .snapshots(),
                            builder: (context, AsyncSnapshot asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                var friend = asyncSnapshot.data;
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(friend['image']),
                                  ),
                                  title: Text(
                                    friend['Name'],
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  subtitle: Container(
                                    child: Text(
                                      friend['status'],
                                      style:const TextStyle(color: Color.fromARGB(255, 133, 133, 133)),
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
                                                friendImage: friend['image'])));
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
