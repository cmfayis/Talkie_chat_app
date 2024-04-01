import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/call/view/status_textpage.dart';
import 'package:chat_app/application/feature/call/view/status_view.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:status_view/status_view.dart';

class Call extends StatefulWidget {
  const Call({Key? key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  late String img;
  String? id;
  @override
  Widget build(BuildContext context) {
    String? image;
    User? user = FirebaseAuth.instance.currentUser;
    String name = '';
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusTextPage(
                      image: image,
                      name: name,
                      id: id,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            BlocProvider.of<SettingBloc>(context).add(intialEvent());
            if (state is FetchState) {
              image = state.imageUrl;
              name = state.name;
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 23),
                    child: Text(
                      "Updates",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image ?? ''),
                          radius: 35,
                        ),
                      ),
                      CustomSizedBox(
                        width: 15,
                      ),
                      Text(
                        "My Status",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  CustomSizedBox(
                    hieght: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Other Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('status')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          final documents = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final data = documents[index];
                              id = documents[index].id;
                              img = data['image'];

                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('status')
                                      .doc(id)
                                      .collection('status')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final docs = snapshot.data!.docs;
                                      final datas = docs[index];
                                      final date = datas['timestamp'].toDate();
                                      String formattedTime =
                                          DateFormat("hh:mm a").format(date);
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StatusViewPage(
                                                        data: datas['Data'],
                                                        color: datas['color'],
                                                        image: data['image'],
                                                        date: formattedTime,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, top: 10),
                                          child: Row(
                                            children: [
                                              StatusView(
                                                unSeenColor: Colors.blue,
                                                seenColor: Colors.grey,
                                                radius: 32,
                                                // indexOfSeenStatus: ,
                                                centerImageUrl: data['image'],
                                                numberOfStatus: docs.length,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                children: [
                                                  Text(data['name']),
                                                  Text(
                                                    formattedTime,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  });
                            },
                          );
                        }
                        return SizedBox();
                      },
                    ),
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
