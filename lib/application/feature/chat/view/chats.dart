import 'package:flutter/material.dart';
import 'package:chat_app/application/feature/chat/widget/chatusercard.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 40, // Adjust the width as needed
            height: 40, // Adjust the height as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: const Icon(
              Icons.search_sharp,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        actions: const [
          CircleAvatar(),
          SizedBox(
            width: 15,
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ChatUserCard();
        },
      ),
    );
  }
}
