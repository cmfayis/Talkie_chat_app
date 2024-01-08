import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/widget/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller= TextEditingController();
  final passwordcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            const CustomSizedBox(
              hieght: 60,
            ),
            const Text(
              'Log in to Chatbox',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const CustomSizedBox(
              hieght: 20,
            ),
            const Text(
              'Welcome back! Sign in using your social\n       account or email to continue us',
              style: TextStyle(color: Color.fromARGB(255, 53, 52, 52)),
            ),
            const CustomSizedBox(
              hieght: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('clicked facebook');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: CircleAvatar(
                        radius: 17,
                        child: Image.asset('asset/images/face.webp')),
                  ),
                ),
                const CustomSizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: CircleAvatar(
                        radius: 16, child: Image.asset('asset/images/ggg.png')),
                  ),
                ),
              ],
            ),
            const CustomSizedBox(
              hieght:40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  width: 162,
                  color: Colors.grey,
                ),
                const CustomSizedBox(
                  width: 10,
                ),
                const Text(
                  'or',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const CustomSizedBox(
                  width: 10,
                ),
                Container(
                  height: 2,
                  width: 162,
                  color: Colors.grey,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  CustomTextFormField(controller:emailcontroller,label: 'email',),
                  CustomTextFormField(controller: passwordcontroller)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
