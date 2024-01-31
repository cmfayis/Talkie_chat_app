import 'package:chat_app/application/feature/contacts/view/contact.dart';
import 'package:chat_app/application/feature/setting/view/setting.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/auth_bloc/bloc/auth_bloc.dart';
import '../../call/view/call.dart';
import '../../chat/view/chats.dart';
import '../Homebloc/home_bloc.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Widget> screens = <Widget>[
    const chats(),
    const Call(),
    const Contacts(),
    const Setting(),
  ];
  GlobalKey<CurvedNavigationBarState> curvednavigationkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is UnAuthenticatedState) {
        Navigator.pushReplacementNamed(context, '/Login');
      }
    }, builder: (context, state) {
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
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ],
  // unselectedLabelStyle:const TextStyle(color: Colors.green),
  key: curvednavigationkey,
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
    });
  }
}
