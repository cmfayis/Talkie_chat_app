import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class StatusViewPage extends StatefulWidget {
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
  final date;

  @override
  State<StatusViewPage> createState() => _StatusViewPageState();
}

class _StatusViewPageState extends State<StatusViewPage> {
  late StoryController controller;

  @override
  void initState() {
    super.initState();
    controller = StoryController();
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF000000 + widget.color), // Corrected color calculation
      body: StoryView(
        indicatorForegroundColor: Colors.grey,
        onComplete: () {
          Navigator.pop(context);
        },
        storyItems: [
          StoryItem.text(
            shown: true,
            duration: Duration(seconds: 3),
            title: widget.data, textStyle: TextStyle(fontSize: 18),
            backgroundColor:
                Color(0xFF000000 + widget.color), // Corrected color calculation
          ),
        ],
        controller: controller,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            // Added background color for container
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
                backgroundColor: Colors.blue, // Placeholder color
              ),
              title: Text(
                'Fayis', // Example name, replace with actual name
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              subtitle:
                  Text(widget.date), // Example time, replace with actual time
            ),
          ),
        ),
      ),
    );
  }
}
