import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:chat_app/application/feature/personalData/widget/bottomsheet.dart';
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
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
       if(state is FileSendState){
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => bottomSheet(context),
          );
       }
      },
      child: Container(
        color: Color(0xFFECE5DD),
        padding: const EdgeInsetsDirectional.all(8),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        BlocProvider.of<ChatBloc>(context).add(FileSendEvent());
                      },
                      icon: const Icon(Icons.attach_file)),
                  contentPadding: const EdgeInsets.only(top: 10, left: 14),
                  hintText: "Type your Message",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20))),
            )),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                String message = _controller.text;
                _controller.clear();
                if (message.isNotEmpty) {
                  BlocProvider.of<ChatBloc>(context).add(SendEvent(
                      message: message,
                      currentId: widget.currentId,
                      friendId: widget.friendId));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 31, 117, 101),
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
