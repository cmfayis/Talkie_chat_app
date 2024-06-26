import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendImageEvent>((event, emit) async {
      emit(LodingImageState());
      try {
        String fileName = const Uuid().v1();
        File imageFile = File(event.image.path);

        var ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child("$fileName.jpg");
        var uploadTask = ref.putFile(imageFile);
        var snapshot = await uploadTask.whenComplete(() => null);
        String imageUrl = await snapshot.ref.getDownloadURL();

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

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.currentId)
            .collection('messages')
            .doc(event.friendId)
            .set({
          'last_msg': "Photo",
          'Time': DateTime.now(),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.friendId)
            .collection('messages')
            .doc(event.currentId)
            .set({
          'last_msg': 'Photo',
          'Time': DateTime.now(),
        });

        emit(SendImageState());
      } catch (error) {
        print("Error: $error");
      }
    });

    on<ShowImageEvent>((event, emit) {
      emit(ShowImagesState());
    });
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
          'Time': DateTime.now(),
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
            .set({
          "last_msg": event.message,
          'Time': DateTime.now(),
        });
      });
    });
    on<FileSendEvent>((event, emit) {
      emit(FileSendState());
    });
    on<GalleryImagesEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      String fileName = const Uuid().v1();

      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          emit(GalleryImageSentSuccessState(ImageUrl: imageFile));
        }
      } catch (e) {
        print("Error uploading image: $e");
      }
    });
    on<CameraImagesEvent>((event, emit) async {
      final imagePicker = ImagePicker();

      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          emit(GalleryImageSentSuccessState(ImageUrl: imageFile));
        }
      } catch (e) {
        print("Error uploading image: $e");
      }
    });
    on<LocationEvent>((event, emit) async {
      Position? currentPosition;
      String? currentAddress;
      String? message;
      LocationPermission? permission;

      try {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          print('location permission are denied');

          if (permission == LocationPermission.deniedForever) {
            print('location permition are denied forever');
          }
        }

        // Fetch the current position asynchronously and wait for it
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        );
        // emit(GalleryImageSentSuccessState());
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);

        Placemark place = placemarks[0];

        currentAddress =
            "${place.locality},${place.postalCode},${place.street}";
        String latitude = currentPosition.latitude.toString();
        String longitude = currentPosition.longitude.toString();

        message =
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.currentId)
            .collection('messages')
            .doc(event.friendId)
            .collection('chats')
            .add({
          "senderId": event.currentId,
          "receiverId": event.friendId,
          "message": message,
          "type": "link",
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
          "message": message,
          "type": "link",
          "date": DateTime.now(),
        });

        // Update last message
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.currentId)
            .collection('messages')
            .doc(event.friendId)
            .set({
          'last_msg': 'Location',
          'Time': DateTime.now(),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.friendId)
            .collection('messages')
            .doc(event.currentId)
            .set({
          'last_msg': 'Location',
          'Time': DateTime.now(),
        });
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
