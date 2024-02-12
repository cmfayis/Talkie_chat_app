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
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 200),
                decoration: BoxDecoration(
                    color: isMe
                        ? const Color.fromARGB(255, 220, 248, 198)
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      topRight: Radius.circular(15),
                    )),
                child: Text(
                  "${message}\n ${formattedTime}",
                  style: const TextStyle(color: Colors.black),
                )),
          ],
        ),
      ],
    );
  }
}
