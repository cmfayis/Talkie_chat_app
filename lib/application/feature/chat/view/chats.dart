// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/application/feature/SearchFolder/search.dart';
import 'package:chat_app/application/feature/model/usermodel.dart';
import 'package:flutter/material.dart';




class chats extends StatefulWidget {
  UserModel? user;
   chats({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<chats> createState() => _ChatState();
}

class _ChatState extends State<chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight:80,
        title: const Text('Chat App',style: TextStyle(color: Colors.white),),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: () {       
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Search()));
      }),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}
