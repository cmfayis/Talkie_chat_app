import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleMessage extends StatelessWidget {
  final type;
  final currentTime;
  final String message;
  final bool isMe;
  SingleMessage(
      {required this.message,
      required this.isMe,
      required this.currentTime,
      required this.type});
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
             type=='text'?   Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 2, left: 10, right: 10),
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
                      style: TextStyle(
                          fontSize: 17,
                          color: isMe ? Colors.white : Colors.black),
                    )):Container(
                margin: const EdgeInsets.only(right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: MediaQuery.of(context).size.height * 0.30,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(18),
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(message),
                                  fit: BoxFit.fill)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: Text(
                    formattedTime,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
