import 'package:chat_app/application/feature/auth/view/main_page.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:chat_app/application/feature/setting/widget/listtitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    BlocProvider.of<SettingBloc>(context).add(intialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is LogoutState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>const RegisterPage()),
              (route) => false);
        }
        if (state is HomePageState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>const HomePage()),
              (route) => false);
        }
      },
      child: Scaffold(
        
        backgroundColor:const Color.fromARGB(255, 31, 117, 101),
        appBar: AppBar(
          
          centerTitle: true,
          backgroundColor:const Color.fromARGB(255, 31, 117, 101),
          toolbarHeight: 120,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            if (state is FetchState) {
              final name = state.name;
              final image = state.iamgeUrl;
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                child: Column(
                  children: [
                    const CustomSizedBox(
                      hieght: 25,
                    ),
                    Row(
                      children: [
                        const CustomSizedBox(
                          width: 25,
                        ),
                        CircleAvatar(
                            radius: 40, backgroundImage: NetworkImage(image)),
                        const CustomSizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    const CustomSizedBox(hieght: 15),
                    const Divider(),
                    const CustomSizedBox(
                      hieght: 25,
                    ),
                    Listtile(
                        ontap: () {
                          BlocProvider.of<SettingBloc>(context)
                              .add(HomePageEvent());
                        },
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey[100],
                          child: const Icon(Icons.home),
                        ),
                        title: const Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        subtitle: const Text('Home')),
                    const CustomSizedBox(
                      hieght: 15,
                    ),
                    Listtile(
                        ontap: () {
                          BlocProvider.of<SettingBloc>(context)
                              .add(LogoutEvent());
                        },
                        leading: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child:  Icon(Icons.logout),
                        ),
                        title: const Text("Logout",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800)),
                        subtitle:const Text("Logout")),
                         Listtile(
                        ontap: () {
                        },
                        leading: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child:  Icon(Icons.delete),
                        ),
                        title: const Text("Delete Account",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800)),
                        subtitle:const Text("Delete Account")),
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
