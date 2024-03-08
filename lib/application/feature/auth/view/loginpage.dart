// import 'package:animate_do/animate_do.dart';
// import 'package:chat_app/application/feature/auth/auth_bloc/bloc/auth_bloc.dart';
// import 'package:chat_app/application/feature/auth/widget/validate.dart';
// import 'package:chat_app/application/feature/profileview/profileview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SignUpWrapper extends StatelessWidget {
//   const SignUpWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AuthBloc(),
//       child:  SignUpPage(),
//     );
//   }
// }

// class SignUpPage extends StatefulWidget {
//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final formkey = GlobalKey<FormState>();
//    final namecontroller = TextEditingController();
//   final emailcontroller = TextEditingController();
//   final passwordcontroller = TextEditingController();
//   final phonecontoller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//          if (state is AuthenticatedState) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ProfileView()),
//                 (route) => false);
//           });
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//               Color.fromARGB(255, 123, 198, 233),
//               Color.fromARGB(255, 47, 245, 235),
//               Color.fromARGB(255, 37, 125, 181)
//             ])),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(
//                   height: 80,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       FadeInUp(
//                           duration: Duration(milliseconds: 1000),
//                           child: Text(
//                             "Login",
//                             style: TextStyle(color: Colors.white, fontSize: 40),
//                           )),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       FadeInUp(
//                           duration: Duration(milliseconds: 1300),
//                           child: Text(
//                             "Welcome Back",
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Form(
//                       key: formkey,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(60),
//                                 topRight: Radius.circular(60))),
//                         child: Padding(
//                           padding: EdgeInsets.all(30),
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: 60,
//                               ),
//                               FadeInUp(
//                                   duration: Duration(milliseconds: 1400),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: Color.fromRGBO(
//                                                   225, 95, 27, .3),
//                                               blurRadius: 20,
//                                               offset: Offset(0, 10))
//                                         ]),
//                                     child: Column(
//                                       children: <Widget>[
//                                          Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color: Colors
//                                                           .grey.shade200))),
//                                           child: TextFormField(
//                                             controller: passwordcontroller,
//                                             obscureText: true,
//                                             decoration: InputDecoration(
//                                                 hintText: "Name",
//                                                 hintStyle: TextStyle(
//                                                     color: Colors.grey),
//                                                 border: InputBorder.none),
//                                             validator: nameValidate,
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color: Colors
//                                                           .grey.shade200))),
//                                           child: TextFormField(
//                                             controller: emailcontroller,
//                                             decoration: InputDecoration(
//                                                 hintText:
//                                                     "Email or Phone number",
//                                                 hintStyle: TextStyle(
//                                                     color: Colors.grey),
//                                                 border: InputBorder.none),
//                                             validator: emailValidate,
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color: Colors
//                                                           .grey.shade200))),
//                                           child: TextFormField(
//                                             controller: passwordcontroller,
//                                             obscureText: true,
//                                             decoration: InputDecoration(
//                                                 hintText: "Password",
//                                                 hintStyle: TextStyle(
//                                                     color: Colors.grey),
//                                                 border: InputBorder.none),
//                                             validator: PasswordValidate,
//                                           ),
                                          
//                                         ),
//                                          Container(
//                                           padding: EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                   bottom: BorderSide(
//                                                       color: Colors
//                                                           .grey.shade200))),
//                                           child: TextFormField(
//                                             controller: passwordcontroller,
//                                             obscureText: true,
//                                             decoration: InputDecoration(
//                                                 hintText: "Phone",
//                                                 hintStyle: TextStyle(
//                                                     color: Colors.grey),
//                                                 border: InputBorder.none),
//                                             validator: phoneValidate,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               FadeInUp(
//                                   duration: Duration(milliseconds: 1500),
//                                   child: TextButton(
//                                     onPressed: () {
//                                       BlocProvider.of<AuthBloc>(context)
//                                           .add(SignUpButtonClickedEvent());
//                                     },
//                                     child: Text('Already I have a account',
//                                         style: TextStyle(color: Colors.grey)),
//                                   )),
//                               SizedBox(
//                                 height: 23,
//                               ),
//                               FadeInUp(
//                                   duration: Duration(milliseconds: 1600),
//                                   child: MaterialButton(
//                                     onPressed: () {
//                                       final name = namecontroller.text;
//                         final password = passwordcontroller.text;
//                         final email = emailcontroller.text;
//                         final phone = phonecontoller.text;
//                         if (formkey.currentState!.validate()) {
//                           BlocProvider.of<AuthBloc>(context).add(SignupEvent(
//                               email: email,
//                               password: password,
//                               phone: phone,
//                               name: name));
//                         }
//                                     },
//                                     height: 50,
//                                     // margin: EdgeInsets.symmetric(horizontal: 50),
//                                     color: Color.fromARGB(255, 47, 245, 235),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     // decoration: BoxDecoration(
//                                     // ),
//                                     child: Center(
//                                       child: Text(
//                                         "SignUp",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
