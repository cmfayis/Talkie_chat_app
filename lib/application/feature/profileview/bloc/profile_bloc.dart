import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    User? user = FirebaseAuth.instance.currentUser;
    on<SumbitEvent>((event, emit) async {
      final storageRef = FirebaseStorage.instance.ref();
      try {
        TaskSnapshot uploadTask = await storageRef
            .child('profile_images')
            .child(user!.uid)
            .putFile(event.image);
        String imageUrl = await uploadTask.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'image': imageUrl,
        });
        emit(SubmitState());
      } catch (e) {}
    });

    on<ImageButtonEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          emit(ImageSuccessState(image: File(pickedFile.path)));
        } else {
          emit(ImageErrorState(error: 'Please select an image.'));
        }
      } catch (e) {
        emit(ImageErrorState(error: 'Error picking image: $e'));
        print(e.toString());
      }
    });
  }
}
