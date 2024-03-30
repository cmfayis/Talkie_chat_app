import 'dart:io';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:chat_app/application/feature/profileview/bloc/profile_bloc.dart';
import 'package:chat_app/application/feature/profileview/widget/textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? image;
  final namecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SubmitState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        } else if (state is ImageSuccessState) {
          image = state.image;
        } else if (state is ImageErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/bg2.jpeg"),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    CustomSizedBox(
                      hieght: 100,
                    ),
                    const Text(
                      'Upload info',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    const CustomSizedBox(
                      hieght: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ImageButtonEvent());
                      },
                      child: DottedBorder(
                        color: Colors.white,
                        dashPattern: const [15, 5],
                        borderType: BorderType.Circle,
                        child: image != null
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage: FileImage(File(image!.path)),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 120,
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Image.asset(
                                    'asset/images/profile.png',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Nick Name",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 130,
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(SumbitEvent(image: image));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        height: 55,
                        child: Center(child: Text("Continue")),
                      ),
                    ),
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
