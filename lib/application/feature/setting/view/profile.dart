// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/profileview/bloc/profile_bloc.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class Profile extends StatefulWidget {
  final String image;
  final String name;
  final String email;
  Profile({required this.image, required this.name, required this.email});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  File? image;
  String? name;

  @override
  Widget build(BuildContext context) {
    namecontroller.text = widget.name;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ImageSuccessState) {
          image = state.image;
        }
        return BlocListener<SettingBloc, SettingState>(
          listener: (context, state) {
            if (state is UpdateState) {
              name = state.name;
              Navigator.pop(context);
            }
            if (state is BackState) {
              BlocProvider.of<SettingBloc>(context).add(intialEvent());
              Navigator.pop(context);
            }
            if (state is ProfileEditState) {
              showModalBottomSheet(
                backgroundColor: Color(0xffADD8E6),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 16.0),
                          const Text(
                            'Enter Your Name',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          TextField(
                            controller: namecontroller,
                            decoration: const InputDecoration(
                              hintText: 'Enter your text...',
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const CustomSizedBox(
                                  width: 25,
                                ),
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<SettingBloc>(context).add(
                                          UpdateDataEvent(
                                              Data: namecontroller.text));
                                    },
                                    child: Text('Save',style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          child: Scaffold(
            backgroundColor: Color(0xffADD8E6),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<SettingBloc>(context)
                        .add(BackButtonEvent());
                  },
                  icon: Icon(Icons.arrow_back)),
              actions: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(SumbitEvent(image: image));
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  width: 15,
                )
              ],
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Profile',
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
                        image != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(File(image!.path)),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(widget.image),
                              ),
                        Positioned(
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<ProfileBloc>(context)
                                    .add(ImageButtonEvent());
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: const Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Ionicons.camera_outline,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  )),
                            ),
                            right: 5,
                            bottom: 15),
                      ],
                    ),
                    const CustomSizedBox(hieght: 20),
                    name != null
                        ? Text(
                            name!,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    const CustomSizedBox(hieght: 10),
                    Text(
                      'Software Developer',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  name != null
                                      ? Text(
                                          name!,
                                          style: const TextStyle(
                                            fontSize: 19,
                                            color: Colors.black,
                                          ),
                                        )
                                      : Text(
                                          widget.name,
                                          style: const TextStyle(
                                            fontSize: 19,
                                            color: Colors.black,
                                          ),
                                        ),
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<SettingBloc>(context)
                                            .add(ProfileEditEvent());
                                      },
                                      icon: Icon(Icons.edit))
                                ],
                              ),
                              CustomSizedBox(hieght: 15,),
                              Text('Email'),
                              CustomSizedBox(hieght: 10,),
                              Text(
                                widget.email,
                                style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                ),
                              )
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
          ),
        );
      },
    );
  }
}
