import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleMessage extends StatelessWidget {
  final currentTime;
  final String message;
  final bool isMe;
  SingleMessage(
      {required this.message, required this.isMe, required this.currentTime});
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = currentTime.toDate();
    String formattedTime = DateFormat.Hm().format(dateTime);
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10,bottom: 2,left: 10,right: 10),
                    constraints: const BoxConstraints(maxWidth: 200),
                    decoration: BoxDecoration(
                        color: isMe
                            ? const Color(0xFF20A090)
                            : Color.fromARGB(255, 234, 242, 248),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(15),
                        )),
                    child: Text(
                      message,
                      style:  TextStyle(fontSize: 17,color: isMe? Colors.white:Colors.black),
                    )),
                     Padding(
                       padding: const EdgeInsets.only(right: 17),
                       child: Text(formattedTime,style: TextStyle(color: Colors.grey),),
                     )
              ],
            ),
               
          ],
        ),
      ],
    );
  }
}
