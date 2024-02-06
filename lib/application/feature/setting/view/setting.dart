import 'package:chat_app/application/feature/auth/view/main_page.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
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
                  TextButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                  }, child: Text('jfddjf'))
                ],
              ),
            );
          }
          return Scaffold();
        },
      ),
    );
  }
}
