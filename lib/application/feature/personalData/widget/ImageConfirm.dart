import 'dart:io';

import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmImage extends StatelessWidget {
  File imageUrl;
  final currentId;
  final friendId;
  ConfirmImage(
      {required this.imageUrl,
      required this.currentId,
      required this.friendId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
         if(state is SendImageState){
          Navigator.pop(context);
          Navigator.pop(context);
         }
        },
        child: Center(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Image.file(imageUrl),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: ()async {
          BlocProvider.of<ChatBloc>(context).add(SendImageEvent(
              currentId: currentId, friendId: friendId, image: imageUrl));
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
