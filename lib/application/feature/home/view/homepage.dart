import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/application/feature/contacts/view/contact.dart';
import 'package:chat_app/application/feature/setting/view/setting.dart';
import '../../auth/auth_bloc/bloc/auth_bloc.dart';
import '../../call/view/call.dart';
import '../../chat/view/chats.dart';
import '../Homebloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      chats(),
      const Call(),
      const Contacts(),
      const Setting(),
    ];

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          Navigator.pushReplacementNamed(context, '/Login');
        }
      },
      builder: (context, state) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              body: screens.elementAt(state.tabIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message_rounded),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.call),
                    label: 'Call',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Person',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Settings',
                  ),
                ],
                currentIndex: state.tabIndex,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                backgroundColor: const Color.fromARGB(82, 71, 71, 71),
                elevation: 20,
                showUnselectedLabels: true,
                onTap: (value) {
                  BlocProvider.of<HomeBloc>(context)
                      .add(TabChangeEvent(tabIndex: value));
                },
              ),
            );
          },
        );
      },
    );
  }
}
