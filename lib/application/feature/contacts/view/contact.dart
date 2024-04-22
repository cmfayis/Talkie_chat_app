import 'package:animate_do/animate_do.dart';
import 'package:chat_app/application/feature/personalData/personalchat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backround,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: backround,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Contacts',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Search by name....',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('Name',
                        isGreaterThanOrEqualTo: searchController.text)
                    .where('Name', isLessThan: searchController.text + 'z')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: backround,
                    ));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text(
                      'No contacts found.',
                      style: GoogleFonts.poppins(),
                    ));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      if (data['uid'] ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        return SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: FadeInUp(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    friendId: data['uid'],
                                    friendName: data['Name'],
                                    friendImage: data['image'],
                                    token: '',
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Container(
                                width: 55,
                                height: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(data['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                data['Name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                data['Email'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Icon(
                                Icons.message,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
