import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 9, 48, 79),
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final data = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(data['image']),
                    ),
                    // title: data['Name'],
                  ),
                );
              },
              itemCount: snapshot.data.docs.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}
