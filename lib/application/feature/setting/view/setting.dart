
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
   Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
 User ?user =FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 120,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: const Column(
          children: [
            CustomSizedBox(
              hieght: 25,
            ),
            Row(
              children: [
                CustomSizedBox(
                  width: 25,
                ),
                CircleAvatar(
                // backgroundImage: NetworkImage(),
                  radius: 40,
                ),
                CustomSizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      'fayis',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text('fayis')
                  ],
                )
              ],
              
            ),
            CustomSizedBox(hieght: 15,),
            Divider(),
          ],
        ),
      ),
    );
  }
}
