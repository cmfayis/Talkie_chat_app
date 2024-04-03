import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/personalData/personalchat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 9, 48, 79),
        title: Text(
          'Contacts',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 72,
                  thickness: 1,
                );
              },
              itemBuilder: (context, index) {
                final data = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListTile(
                    leading: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                  friendId: data['uid'],
                                  friendName: data['Name'],
                                  friendImage: data['image'],
                                  token: data['token'])),
                        );
                      },
                      child: Container(
                        width: 55,
                        height: 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(data['image']),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    title: Text(
                      data['Name'],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(data['Email']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.phone_circle_fill,
                          size: 35,
                          color: Color.fromARGB(255, 9, 48, 79),
                        ),
                        CustomSizedBox(
                          width: 13,
                        ),
                        Icon(
                          CupertinoIcons.videocam_circle_fill,
                          size: 35,
                          color: Color.fromARGB(255, 9, 48, 79),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.docs.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
