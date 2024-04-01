import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class StatusViewPage extends StatelessWidget {
  const StatusViewPage({
    Key? key,
    required this.data,
    required this.color,
    required this.image,
    required this.date,
  }) : super(key: key);

  final String data;
  final int color;
  final dynamic image;
  final dynamic date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000 + color), // Corrected color calculation
      body: StoryView(
        indicatorForegroundColor: Colors.grey,
        storyItems: List.generate(
          data.length,
          (index) => StoryItem.text(
            shown: true,
            duration: Duration(seconds: 3),
            title: data[index],
            textStyle: TextStyle(fontSize: 18),
            backgroundColor:
                Color(0xFF000000 + color), // Corrected color calculation
          ),
        ),
        onComplete: () {
          Navigator.pop(context);
        },
        controller: StoryController(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.white, // Adjust background color as needed
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.blue, // Placeholder color
              ),
              title: Text(
                'Fayis', // Example name, replace with actual name
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              subtitle: Text(
                date.toString(), // Example time, replace with actual time
              ),
            ),
          ),
        ),
      ),
    );
  }
}
