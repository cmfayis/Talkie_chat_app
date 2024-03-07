import 'package:chat_app/application/feature/personalData/widget/showimage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 2, left: 10, right: 10),
                        constraints: const BoxConstraints(maxWidth: 200,minWidth: 80),
                        decoration: BoxDecoration(
                            color: isMe
                                ? const Color(0xff4FB6EC)
                                : Color.fromARGB(255, 234, 242, 248),
                            borderRadius: const BorderRadius.all(Radius.circular(12))
                              

                            ),
                        child: Text(
                          message,
                          style: TextStyle(
                              fontSize: 17,
                              color: isMe ? Colors.white : Colors.black),
                        ))
                    : Container(
                        margin: const EdgeInsets.only(right: 20, top: 10),
                        child: type == "link"
                            ?   Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.all(16),
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
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
                                        child:  Container(
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
                                                      ?  const Color(
                                                          0xffADD8E6):Colors.grey
                                                      ),
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
                  padding: const EdgeInsets.only(right: 17),
                  child: Text(
                    formattedTime,
                    style: TextStyle(color: Colors.grey,fontSize: 10),
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
