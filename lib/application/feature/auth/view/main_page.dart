import 'package:flutter/material.dart';
import '../widget/sizedbox.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                const CustomSizedBox(
                  hieght: 155,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Connect\nfriends',
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                      TextSpan(
                        text: '\neasily &\nquickly\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text:
                            '\nOur chat app is the perfect way to stay \nconnected with friends and family.',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 17, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  hieght: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        print('clicked facebook');
                      },
                      child: CircleAvatar(
                          radius: 25,
                          child: Image.asset('asset/images/face.webp')),
                    ),
                    const CustomSizedBox(
                      hieght: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                          radius: 25,
                          child: Image.asset('asset/images/google.png')),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, top: 25),
                  child: Row(
                    children: [
                      Container(
                        height: 2,
                        width: 140,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                // Text("Connect\nfriends\neasily &\nquickly",style: TextStyle(color: Colors.white,fontSize: 35),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
