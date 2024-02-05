import 'dart:io';

import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
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
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (state is ImageSuccessState) {
          image = state.image;
        } else if (state is ImageErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomSizedBox(
                    hieght: 50,
                  ),
                  const Text(
                    'Upload info',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  const CustomSizedBox(
                    hieght: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(ImageButtonEvent());
                    },
                    child: DottedBorder(
                      // padding: EdgeInsets.all(10),
                      dashPattern: const [15, 5],
                      borderType: BorderType.Circle,
                      child: image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(File(image!.path)),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 100,
                              child: Padding(
                                padding: EdgeInsets.all(18),
                                child: Image.asset('asset/images/profile.png'),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: TextFieldWidget(
                      controller: namecontroller,
                      hintText: 'Name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23, right: 23),
                    child: TextFieldWidget(
                      controller: descriptioncontroller,
                      hintText: 'Description',
                      lines: 4,
                    ),
                  ),
                  const CustomSizedBox(
                    hieght: 95,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(SumbitEvent(image: image));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        height: 55,
                        child: Center(child: Text("Continue")),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
