import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
on<ImageStoregeEvent>((event, emit)async {
final storageRef = FirebaseStorage.instance.ref();
   try {
     TaskSnapshot result =
        await storageRef.child('profile_images').child(event.uid).putFile(event.image);
   } catch (e) {
     
   }
});


    




    on<ImageButtonEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.camera);

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
