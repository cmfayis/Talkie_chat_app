import 'package:chat_app/application/feature/auth/auth_bloc/bloc/auth_bloc.dart';
import 'package:chat_app/application/feature/auth/view/main_page.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:chat_app/application/feature/splash/widget/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPageWrapper extends StatelessWidget {
  const SplashPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushReplacement(
              context,
              FadeRoute2(HomePage(
              )));
        } else if (state is UnAuthenticatedState) {
          Navigator.pushReplacement(context, FadeRoute2(RegisterPageWrapper()));
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("asset/images/splash.png", width: 230),
              ),
              Text(
                "Chat App",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
