
import 'package:chat_app/application/feature/call/view/call.dart';
import 'package:chat_app/application/feature/chat/view/chats.dart';
import 'package:chat_app/application/feature/contacts/view/contact.dart';
import 'package:chat_app/application/feature/setting/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../Homebloc/home_bloc.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<Widget> screens = <Widget>[
     chats(),
    const Call(),
    const Contacts(),
    const Setting(),
  ];

  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: homeBloc,
      builder: (context, state) {
        return Scaffold(
          body: screens.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(           
            items:  [
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.chatbox_ellipses_outline),
                  label: 'chats'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.call_outline), label: 'calls'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.people_circle_outline),
                  label: 'contacts'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.person_outline), label: 'profile')
            ],
            currentIndex: state.tabIndex,
            fixedColor: Color(0xff4FB6EC),
            unselectedItemColor: const Color.fromARGB(255, 207, 205, 205),
            onTap: (value) {
              homeBloc.add(
                TabChangeEvent(tabIndex: value),
              );
            },
          ),
        );
      },
    );
  }
}
