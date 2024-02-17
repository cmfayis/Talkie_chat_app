import 'package:chat_app/application/feature/auth/widget/custombutton.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/auth/widget/validate.dart';
import 'package:chat_app/application/feature/profileview/profileview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_bloc/bloc/auth_bloc.dart';
import '../widget/customtextfield.dart';

class SignUpWrapper extends StatelessWidget {
  const SignUpWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontoller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
                (route) => false);
          });
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const CustomSizedBox(
                    hieght: 25,
                  ),
                  const Text(
                    'Sign up with Email',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const CustomSizedBox(
                    hieght: 20,
                  ),
                  const Text(
                    'Get chatting with friends and family today by\n              signing up for our chat app!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 53, 52, 52), fontSize: 15),
                  ),
                  const CustomSizedBox(
                    hieght: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: namecontroller,
                          hintText: 'Name',
                          label: 'Name',
                          validator: nameValidate,
                        ),
                        const CustomSizedBox(
                          hieght: 25,
                        ),
                        CustomTextFormField(
                          controller: phonecontoller,
                          hintText: 'Phone',
                          label: 'Phone',
                          validator: phoneValidate,
                        ),
                        const CustomSizedBox(
                          hieght: 25,
                        ),
                        CustomTextFormField(
                          controller: emailcontroller,
                          hintText: 'Email',
                          label: 'Email',
                          validator: emailValidate,
                        ),
                        const CustomSizedBox(
                          hieght: 25,
                        ),
                        CustomTextFormField(
                          controller: passwordcontroller,
                          label: 'Password',
                          hintText: 'Password',
                          obscureText: true,
                          validator: PasswordValidate,
                        ),
                      ],
                    ),
                  ),
                  const CustomSizedBox(
                    hieght: 40,
                  ),
                  CustomButton(
                      ontap: () {
                        final name = namecontroller.text;
                        final password = passwordcontroller.text;
                        final email = emailcontroller.text;
                        final phone = phonecontoller.text;
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(SignupEvent(
                              email: email,
                              password: password,
                              phone: phone,
                              name: name));
                        }
                      },
                      width: double.infinity,
                      hieght: 45,
                      color: const Color(0xffADD8E6),
                      text: 'SignUp'),            
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
