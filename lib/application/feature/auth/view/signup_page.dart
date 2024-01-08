import 'package:chat_app/application/feature/auth/model/model.dart';
import 'package:chat_app/application/feature/auth/widget/custombutton.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/widget/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_bloc/bloc/auth_bloc.dart';

class SignUpWrapper extends StatelessWidget {
  const SignUpWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SignUpPage(),
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, "/home");
          });
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomSizedBox(
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
                      ),
                      const CustomSizedBox(
                        hieght: 25,
                      ),
                      CustomTextFormField(
                        controller: phonecontoller,
                        hintText: 'Phone',
                        label: 'Phone',
                      ),
                      const CustomSizedBox(
                        hieght: 25,
                      ),
                      CustomTextFormField(
                        controller: emailcontroller,
                        hintText: 'Email',
                        label: 'Email',
                      ),
                      const CustomSizedBox(
                        hieght: 25,
                      ),
                      CustomTextFormField(
                        controller: passwordcontroller,
                        label: 'Password',
                        hintText: 'Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  hieght: 100,
                ),
                CustomButton(
                    ontap: () {
                      final user = UserModel(
                        name: namecontroller.text,
                        password: passwordcontroller.text,
                        email: emailcontroller.text,
                        phone: phonecontoller.text,
                      );
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignupEvent(user: user));
                    },
                    width: double.infinity,
                    hieght: 45,
                    color: Color.fromARGB(31, 49, 48, 48),
                    text: 'SignUp'),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Already I have an account',
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
