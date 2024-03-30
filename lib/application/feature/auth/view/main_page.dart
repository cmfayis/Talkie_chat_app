import 'package:chat_app/application/feature/auth/auth_bloc/bloc/auth_bloc.dart';
import 'package:chat_app/application/feature/auth/view/Login.dart';

import 'package:chat_app/application/feature/auth/view/signup_page.dart';
import 'package:chat_app/application/feature/profileview/profileview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageWrapper extends StatelessWidget {
  const RegisterPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileView()),
                  (route) => false);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 120,
              backgroundColor: const Color.fromARGB(255, 9, 48, 79),
              centerTitle: true,
              title: Text(
                'Talkie',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Sign Up',
                  ),
                  Tab(text: 'Sign In'),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
            ),
            bottomSheet: Container(
              height: 75,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 48, 79),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
            ),
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              children: [
                SignUpScreen(),
                LoginPageWrapper(),
              ],
            ),
          );
        },
      ),
    );
  }
}
