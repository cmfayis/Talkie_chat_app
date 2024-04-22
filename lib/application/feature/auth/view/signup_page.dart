import 'package:animate_do/animate_do.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';
import '../auth_bloc/bloc/auth_bloc.dart';
import '../widget/validate.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GoogleButtonState) {
          Get.off(Home());
        } else if (state is AuthenticatedState) {
          Get.off(Home());
        } else if (state is ErrorAuthenctionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up failed. Please try again.'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "Create An Account",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: backround),
                    ),
                    SizedBox(height: 40),
                    FadeInUp(
                      duration: Duration(milliseconds: 1600),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: namecontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: backround,
                            ),
                            hintText: 'Username',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                          validator: nameValidate,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1600),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: backround,
                            ),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                          validator: emailValidate,
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Adjust the spacing as needed
                    FadeInUp(
                      duration: Duration(milliseconds: 1600),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: backround,
                            ),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(8),
                          ),
                          obscureText: true,
                          validator: PasswordValidate,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 1600),
                      child: MaterialButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            final name = namecontroller.text;
                            final password = passwordcontroller.text;
                            final email = emailcontroller.text;
                            final phone = "xokk";

                            BlocProvider.of<AuthBloc>(context).add(SignupEvent(
                              email: email,
                              password: password,
                              phone: phone,
                              name: name,
                            ));
                          }
                        },
                        height: 50,
                        color: backround,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 2,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Or Sign up With",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 50,
                              height: 2,
                              color: Colors.black,
                            ),
                          ],
                        )),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: MaterialButton(
                              elevation: 10,
                              onPressed: () {},
                              height: 50,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(GoogleButtonEvent());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "asset/images/ggg.png",
                                      height: 28,
                                    ),
                                    Text(
                                      "Google",
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 19,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: backround,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "f",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Facebook",
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
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
