import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:const EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: "Type your Message",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                    borderSide:const BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25))),
          )),
        const  SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async {
              String message = _controller.text;
              _controller.clear();
              BlocProvider.of<ChatBloc>(context).add(SendEvent(
                  message: message,
                  currentId: widget.currentId,
                  friendId: widget.friendId));
            },
            child: Container(
              padding:const EdgeInsets.all(8),
              decoration:const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child:const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
