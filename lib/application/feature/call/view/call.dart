import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:chat_app/application/feature/call/view/status_textpage.dart';
import 'package:chat_app/application/feature/call/view/status_view.dart';
import 'package:chat_app/application/feature/setting/bloc/bloc/setting_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingBloc>(context).add(intialEvent());
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
                      // id: id,
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
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('status')
                        .doc(user?.uid)
                        .collection('status')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        if (docs.isNotEmpty) {
                          final datas = docs.first;
                          final date = datas['timestamp'].toDate();
                          String formattedTime =
                              DateFormat("hh:mm a").format(date);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StatusViewPage(
                                    name: name,
                                    id: user!.uid,
                                    color: datas['color'],
                                    image: image,
                                    date: formattedTime,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 2, bottom: 10),
                              child: Row(
                                children: [
                                  StatusView(
                                    unSeenColor: Colors.green,
                                    seenColor: Colors.grey,
                                    radius: 28,
                                    centerImageUrl: image!,
                                    numberOfStatus: docs.length,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        formattedTime,
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                      // User doesn't have a story
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StatusTextPage(
                                image: image,
                                name: name,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(image ?? ''),
                                          radius: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 2,
                                      right: -2,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Status",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Tap to add status update",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
                              final id = documents[index].id;
                              img = data['image'];

                              return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('status')
                                      .doc(id)
                                      .collection('status')
                                      // .where('uid', isNotEqualTo: user!.uid)
                                      .orderBy("timestamp", descending: false)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final docs = snapshot.data!.docs;
                                      final datas = docs[index];
                                      // print(datas['Data']);
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
                                                        name: data['name'],
                                                        id: id!,
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
