import 'package:chat_app/application/feature/auth/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StoryController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffADD8E6),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Color(0xffADD8E6),
                    borderRadius: BorderRadius.all(Radius.circular(13))),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                )),
            const CustomSizedBox(
              hieght: 15,
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Color(0xffADD8E6),
                    borderRadius: BorderRadius.all(Radius.circular(13))),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.camera_outline,
                    ))),
          ],
        ),
        body: StoryView(
          controller: controller,
          inline: false, // pass controller here too
          repeat: true, // should the stories be slid forever

          onComplete: () {},
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
          storyItems: [
          StoryItem(Text('veiw'), duration: Duration(seconds: 10)),
            StoryItem(Text('veiw'), duration: Duration(seconds: 10)),
          ], // To disable vertical swipe gestures, ignore this parameter.
          // Preferrably for inline story view.
        ));
  }
}
