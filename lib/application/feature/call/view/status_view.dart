import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StatusViewPage extends StatelessWidget {
  const StatusViewPage({
    Key? key,
    required this.name,
    required this.color,
    required this.image,
    required this.date,
    required this.id,
  }) : super(key: key);
  final String name;
  final String id;
  final int color;
  final dynamic image;
  final dynamic date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000 + color),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('status')
            .doc(id)
            .collection('status')
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return StoryView(
              indicatorForegroundColor: Colors.grey,
              storyItems: List.generate(
                documents.length,
                (index) => StoryItem.text(
                  shown: true,
                  duration: Duration(seconds: 3),
                  title: documents[index]['Data'],
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Color(0xFF000000 + color),
                ),
              ),
              onComplete: () {
                Navigator.pop(context);
              },
              controller: StoryController(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.transparent,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.blue,
              ),
              title: Text(
                name,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              subtitle: Text(
                date.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
