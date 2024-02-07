import 'package:flutter/material.dart';


class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  SingleMessage({
    required this.message,
    required this.isMe
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              constraints: BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                color: isMe ? Color.fromARGB(255, 46, 150, 141) : Colors.grey[300],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft:Radius.circular(12),bottomRight: Radius.circular(12) )
              ),
              child: Text(message,style: TextStyle( color:isMe? Colors.white:Colors.black),)
            ),
          ],
          
        ),
      ],
    );
  }
}