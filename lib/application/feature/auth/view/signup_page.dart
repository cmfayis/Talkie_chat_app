import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
           ),
      body:const Center(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Text('Sign up with Email',style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800 ),),
            SizedBox(height: 20,),
            Text('Get chatting with friends and family today by\n     signing up for our chat app!')
          ],
        ),
      ),
    );
  }
}