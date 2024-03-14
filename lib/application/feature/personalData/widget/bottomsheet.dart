import 'dart:io';
import 'package:chat_app/application/feature/personalData/bloc/bloc/chat_bloc.dart';
import 'package:chat_app/application/feature/personalData/widget/ImageConfirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

Widget bottomSheet(BuildContext context, String currentId, String friendId) {
  return BlocConsumer<ChatBloc, ChatState>(
    listener: (context, state) {
      if (state is GalleryImageSentSuccessState) {
        File imageUrl = state.ImageUrl;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmImage(
              imageUrl: imageUrl,
              currentId: currentId,
              friendId: friendId,
            ),
          ),
        );
      }
    },
    builder: (context, state) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              chatIcon(Ionicons.location_outline, "Location", () {
                BlocProvider.of<ChatBloc>(context).add(
                  LocationEvent(currentId: currentId, friendId: friendId),
                );
              }),
              chatIcon(Ionicons.camera_outline, "Camera", () {
                BlocProvider.of<ChatBloc>(context).add(
                  CameraImagesEvent(),
                );
              }),
              chatIcon(Ionicons.images_outline, "Photo", () {
                BlocProvider.of<ChatBloc>(context).add(
                  GalleryImagesEvent(),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}

chatIcon(IconData icon, String title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[200],
          radius: 30,
          child: Icon(
            icon,
          ),
        ),
        Text("$title"),
      ],
    ),
  );
}
