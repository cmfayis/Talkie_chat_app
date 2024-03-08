import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/call/view/status_textpage.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    String? image;
    String name = 'My Status';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            CustomSizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Ionicons.camera_outline,
                color: Colors.blue,
              ),
            ),
            CustomSizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusTextPage()));
              },
              child: Container(
                  margin: EdgeInsets.only(right: 15),
                  padding: EdgeInsets.all(2),
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 22,
                  )),
            ),
          ],
        ),
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            BlocProvider.of<SettingBloc>(context).add(intialEvent());
            if (state is FetchState) {
              image = state.imageUrl;
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 23),
                    child: Text(
                      "Updates",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image ?? ''),
                          radius: 25,
                        ),
                      ),
                      CustomSizedBox(
                        width: 15,
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
