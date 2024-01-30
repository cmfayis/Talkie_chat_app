import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  // final UserModel currentUser;
  final String friendId;
  final String friendName;
  // final String friendImage;
  ChatPage({
    Key? key,
    // required this.currentUser,
    required this.friendId,
    required this.friendName,
    // required this.friendImage,
  }) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(80),
            //   child: Image.network(
            //     friendImage,
            //     height: 35,
            //   ),
            // ),
            const SizedBox(
              width: 5,
            ),
            Text(
              friendName,
              style:const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}