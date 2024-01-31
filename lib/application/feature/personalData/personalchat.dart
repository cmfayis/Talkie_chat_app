import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  // final UserModel currentUser;
  // final String friendId;
  final String friendName;
  // final String friendImage;
  ChatPage({
    Key? key,
    // required this.currentUser,
    // required this.friendId,
    required this.friendName,
    // required this.friendImage,
  }) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 243, 220, 220),
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
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: <Widget>[
                const SizedBox(
                    width: 10), // Add some space between text and TextField
                const Flexible(
                  // Use Flexible to allow TextField to occupy remaining space
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Message',
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  child:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
