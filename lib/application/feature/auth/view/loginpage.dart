import 'package:chat_app/application/feature/auth/model/model.dart';
import 'package:chat_app/application/feature/auth/widget/custombutton.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/widget/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_bloc/bloc/auth_bloc.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
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
                            radius: 16,
                            child: Image.asset('asset/images/ggg.png')),
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  hieght: 45,
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
                CustomSizedBox(
                  hieght: 45,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      final user =UserModel(
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                      );
                      BlocProvider.of<AuthBloc>(context).add(LoginEvent(user: user));
                    },
                    width: double.infinity,
                    hieght: 45,
                    color: Color.fromARGB(31, 49, 48, 48),
                    text: 'Login'),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "I Don't have any account ",
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
