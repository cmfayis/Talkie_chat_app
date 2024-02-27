// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';

import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class FriendProfile extends StatefulWidget {
  final String image;
  final String name;
  final String email;
  FriendProfile({required this.image, required this.name, required this.email});

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  File? image;
  String? name;

  @override
  Widget build(BuildContext context) {
    namecontroller.text = widget.name;
    return Scaffold(
      backgroundColor: Color(0xffADD8E6),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'FriendProfile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffADD8E6),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CustomSizedBox(
                hieght: 40,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ],
              ),
              const CustomSizedBox(hieght: 20),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CustomSizedBox(hieght: 10),

              const CustomSizedBox(hieght: 42),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        topRight: Radius.circular(70))),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomSizedBox(
                          hieght: 40,
                          width: double.infinity,
                        ),
                        const Text(
                          'Display Name',
                        ),
                   const     CustomSizedBox(hieght: 10,),
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Text('data')
            ],
          ),
        ),
      ),
    );
  }
}
