import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_app/application/feature/SearchFolder/bloc/search_bloc.dart';
import 'package:chat_app/application/feature/auth/auth_bloc/bloc/auth_bloc.dart';
import 'package:chat_app/application/feature/auth/view/Login.dart';
import 'package:chat_app/application/feature/auth/view/main_page.dart';
import 'package:chat_app/application/feature/auth/view/signup_page.dart';
import 'package:chat_app/application/feature/call/bloc/bloc/status_bloc.dart';
import 'package:chat_app/application/feature/home/Homebloc/home_bloc.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:chat_app/application/feature/profileview/bloc/profile_bloc.dart';
import 'package:chat_app/application/feature/profileview/profileview.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:chat_app/application/feature/splash/splash.dart';
import 'package:chat_app/application/feature/viedo_call/widget/cutomfunction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "call_channel",
        channelName: "Calls Channel",
        channelDescription: "Channel with ringtone",
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone)
  ]);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleSignIn().signInSilently();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => StatusBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPageWrapper(),
          '/home': (context) => Home(),
          '/register': (context) => const RegisterPageWrapper(),
          '/Login': (context) => const LoginPageWrapper(),
          '/SignUp': (context) => SignUpScreen(),
          '/Profile': (context) => const ProfileView(),
        },
      ),
    );
  }
}
