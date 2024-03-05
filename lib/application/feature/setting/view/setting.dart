import 'package:chat_app/application/feature/auth/view/main_page.dart';
import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/home/view/homepage.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:chat_app/application/feature/setting/view/faq.dart';
import 'package:chat_app/application/feature/setting/view/profile.dart';
import 'package:chat_app/application/feature/setting/view/terms.dart';
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
        // appBar: AppBar(
        //   backgroundColor: Color(0xffADD8E6),
        //   title: const Text(
        //     'Settings',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
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
             
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(               
                    children: [
                      const CustomSizedBox(
                        hieght: 75,
                      ),
                      Text('Profile',style: TextStyle(fontSize: 25),),
                      const CustomSizedBox(
                        hieght: 25,
                      ),
                      InkWell(
                        onTap: () {
                         
                        },
                        child: Center(
                          child: CircleAvatar(
                              radius: 50, backgroundImage: NetworkImage(image)),
                        ),
                      ),
                       const CustomSizedBox(
                        hieght: 15,
                      ),
                      Text(name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                      const CustomSizedBox(
                        hieght: 5,
                      ),
                      Text(email,style: TextStyle(fontSize: 16),),
                        const CustomSizedBox(
                        hieght: 15,
                      ),
                      Divider(
                        color:Color(0xffADD8E6) ,
                        thickness: 4,
                        indent: 50,
                        endIndent: 50,
                      ),
                        const CustomSizedBox(
                        hieght: 15,
                      ),
                        Listtile(
                        ontap: () {
                         Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(
                                        image: image,
                                        name: name,
                                        email: email,
                                      )));
                        },
                        leading: Icon(Icons.edit_outlined ),
                        title: const Text(
                          "Edit Profile",
                        ),
                      ),
                       Listtile(
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms()));
                        },
                        leading: const Icon(Icons.policy),
                        title: const Text(
                          "Terms and Conditions",
                        ),
                      ),
                       Listtile(
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Faq()));
                        },
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
                        leading: Icon(Icons.delete,color: Colors.red,),
                        title: const Text(
                          "Delete Account",style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
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
