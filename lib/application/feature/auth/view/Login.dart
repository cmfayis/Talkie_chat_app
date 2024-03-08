import 'package:animate_do/animate_do.dart';
import 'package:chat_app/application/feature/auth/auth_bloc/bloc/auth_bloc.dart';
import 'package:chat_app/application/feature/auth/widget/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child:  LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          });
        }
        if (state is ErrorAuthenctionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is GoogleButtonState) {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        }
        if (state is SignUpButtonClickedState) {
          Navigator.pushNamed(context, '/SignUp');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 123, 198, 233),
              Color.fromARGB(255, 47, 245, 235),
              Color.fromARGB(255, 37, 125, 181)
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1300),
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 60,
                              ),
                              FadeInUp(
                                  duration: Duration(milliseconds: 1400),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  225, 95, 27, .3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: TextFormField(
                                            controller: emailcontroller,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Email or Phone number",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            validator: emailValidate,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200))),
                                          child: TextFormField(
                                            controller: passwordcontroller,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            validator: PasswordValidate,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              FadeInUp(
                                  duration: Duration(milliseconds: 1500),
                                  child: TextButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(SignUpButtonClickedEvent());
                                    },
                                    child: Text('Already I have a account',
                                        style: TextStyle(color: Colors.grey)),
                                  )),
                              SizedBox(
                                height: 23,
                              ),
                              FadeInUp(
                                  duration: Duration(milliseconds: 1600),
                                  child: MaterialButton(
                                    onPressed: () {
                                      final password = passwordcontroller.text;
                                      final email = emailcontroller.text;
                                      if (formkey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                            LoginEvent(
                                                password: password,
                                                email: email));
                                      }
                                    },
                                    height: 50,
                                    // margin: EdgeInsets.symmetric(horizontal: 50),
                                    color: Color.fromARGB(255, 47, 245, 235),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    // decoration: BoxDecoration(
                                    // ),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 50,
                              ),
                              FadeInUp(
                                  duration: Duration(milliseconds: 1700),
                                  child: Text(
                                    "Continue with social media",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FadeInUp(
                                        duration: Duration(milliseconds: 1800),
                                        child: MaterialButton(
                                          onPressed: () {},
                                          height: 50,
                                          color: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Facebook",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: FadeInUp(
                                        duration: Duration(milliseconds: 1900),
                                        child: MaterialButton(
                                          onPressed: () {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(GoogleButtonEvent());
                                          },
                                          height: 50,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          color: Colors.black,
                                          child: Center(
                                            child: Text(
                                              "Google",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
