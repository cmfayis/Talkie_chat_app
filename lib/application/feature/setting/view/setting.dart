import 'package:chat_app/application/feature/auth/view/main_page.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:chat_app/application/feature/setting/view/profile.dart';
import 'package:chat_app/application/feature/setting/widget/listtitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is LogoutState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
              (route) => false);
        }
        if (state is HomePageState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color(0xffADD8E6),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            BlocProvider.of<SettingBloc>(context).add(intialEvent());
            if (state is FetchState) {
              final email = state.email;
              final name = state.name;
              final image = state.imageUrl;
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const CustomSizedBox(
                      hieght: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      image: image,
                                      name: name,
                                      email: email,
                                    )));
                      },
                      child: Center(
                        child: CircleAvatar(
                            radius: 60, backgroundImage: NetworkImage(image)),
                      ),
                    ),
                    const CustomSizedBox(
                      hieght: 15,
                    ),
                     Listtile(
                      ontap: () {},
                      leading: const Icon(Icons.support),
                      title: const Text(
                        "Terms and Conditions",
                      ),
                    ),
                     Listtile(
                      ontap: () {},
                      leading: const Icon(Icons.help_outline),
                      title: const Text(
                        "FAQ",
                      ),
                    ),
                    Listtile(
                      ontap: () {},
                      leading: const Icon(Icons.support),
                      title: const Text(
                        "Supports us",
                      ),
                    ),
                    Listtile(
                      ontap: () {
                        BlocProvider.of<SettingBloc>(context)
                            .add(LogoutEvent());
                      },
                      leading: Icon(Icons.logout),
                      title: const Text(
                        "Logout",
                      ),
                    ),
                    Listtile(
                      ontap: () {
                        FirebaseAuth.instance.currentUser!.delete();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      leading: Icon(Icons.delete),
                      title: const Text(
                        "Delete Account",
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Scaffold();
          },
        ),
      ),
    );
  }
}
