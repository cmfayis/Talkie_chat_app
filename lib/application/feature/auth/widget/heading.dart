import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 45),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Connect\nfriends',
              style: TextStyle(color: Colors.white, fontSize: 55),
            ),
            TextSpan(
              text: '\neasily &\nquickly\n',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text:
                  '\nOur chat app is the perfect way to stay \nconnected with friends and family.',
              style: TextStyle(
                  color: Colors.grey, fontSize: 19, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
