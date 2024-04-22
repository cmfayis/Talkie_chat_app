import 'package:chat_app/application/feature/personalData/widget/showimage.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';

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
    String formattedTime = DateFormat("hh:mm a").format(dateTime);
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                type == 'text'
                    ? Container(
                        child: ClipPath(
                          clipper: isMe
                              ? UpperNipMessageClipperTwo(MessageType.send)
                              : UpperNipMessageClipperTwo(MessageType.receive),
                          child: Container(
                              padding: isMe
                                  ? EdgeInsets.only(
                                      top: 8, left: 10, bottom: 8, right: 25)
                                  : EdgeInsets.only(
                                      top: 8, left: 25, bottom: 8, right: 10),
                              constraints: const BoxConstraints(
                                  maxWidth: 280, minWidth: 80),
                              decoration: BoxDecoration(
                                  color: isMe
                                      ? backround
                                      : Color.fromARGB(255, 234, 242, 248),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: Text(
                                message,
                                style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 15,
                                    color: isMe ? Colors.white : Colors.black),
                              )),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 20, top: 10),
                        child: type == "link"
                            ? Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(16),
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                decoration: BoxDecoration(
                                    color: isMe ? Colors.black : Colors.grey,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: GestureDetector(
                                  onTap: () async {
                                    await launchUrl(Uri.parse('$message'));
                                  },
                                  child: Text(
                                    message,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShowImage(
                                                          imageUrl: message)));
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.54,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 4,
                                                  color: isMe
                                                      ? const Color(0xffADD8E6)
                                                      : Colors.grey),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(18),
                                                topLeft: Radius.circular(18),
                                                bottomLeft: Radius.circular(18),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(message),
                                                  fit: BoxFit.fill)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                      ),
                Padding(
                  padding: isMe
                      ? EdgeInsets.only(right: 17, bottom: 5)
                      : EdgeInsets.only(right: 0, bottom: 5),
                  child: Text(
                    formattedTime,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
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
