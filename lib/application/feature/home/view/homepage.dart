import 'package:chat_app/application/feature/call/view/call.dart';
import 'package:chat_app/application/feature/chat/view/chats.dart';
import 'package:chat_app/application/feature/contacts/view/contact.dart';
import 'package:chat_app/application/feature/setting/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/colors.dart';
import '../Homebloc/home_bloc.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<Widget> screens = <Widget>[
    chats(),
    const Status(),
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
            backgroundColor:  backround,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.chatbox_ellipses_outline),
                  label: 'chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.filter_tilt_shift_sharp), label: 'Status'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.people_circle_outline),
                  label: 'contacts'),
              BottomNavigationBarItem(
                  icon: Icon(Ionicons.person_outline), label: 'profile')
            ],
            currentIndex: state.tabIndex,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.grey,
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
