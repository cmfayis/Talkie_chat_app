import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendEvent>((event, emit) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.currentId)
          .collection('messages')
          .doc(event.friendId)
          .collection('chats')
          .add({
        "senderId": event.currentId,
        "receiverId": event.friendId,
        "message": event.message,
        "type": "text",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(event.currentId)
            .collection('messages')
            .doc(event.friendId)
            .set({
          'last_msg': event.message,
        });
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.friendId)
          .collection('messages')
          .doc(event.currentId)
          .collection("chats")
          .add({
        "senderId": event.currentId,
        "receiverId": event.friendId,
        "message": event.message,
        "type": "text",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(event.friendId)
            .collection('messages')
            .doc(event.currentId)
            .set({"last_msg": event.message});
      });
    });
    on<FileSendEvent>((event, emit) {
      emit(FileSendState());
    });
    on<GalleryImagesEvent>((event, emit)async {
       final imagePicker = ImagePicker();
    String fileName = const Uuid().v1();

    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      emit(GalleryImageSentSuccessState());

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        var ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child("$fileName.jpg");
        var uploadTask = await ref.putFile(imageFile);
        String imageUrl = await uploadTask.ref.getDownloadURL();

        // Save the image URL to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.currentId)
            .collection('messages')
            .doc(event.friendId)
            .collection('chats')
            .add({
          "senderId": event.currentId,
          "receiverId": event.friendId,
          "message": imageUrl,
          "type": "img",
          "date": DateTime.now(),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.friendId)
            .collection('messages')
            .doc(event.currentId)
            .collection('chats')
            .add({
          "senderId": event.currentId,
          "receiverId": event.friendId,
          "message": imageUrl,
          "type": "img",
          "date": DateTime.now(),
        });

        // Update last message
        FirebaseFirestore.instance
            .collection('users')
            .doc(event.currentId)
            .collection('messages')
            .doc(event.friendId)
            .set({'last_msg': imageUrl});

        FirebaseFirestore.instance
            .collection('users')
            .doc(event.friendId)
            .collection('messages')
            .doc(event.currentId)
            .set({'last_msg': imageUrl});
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    });
  }
}
