import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      
    });
    on<ImageButtonEvent>((event, emit) async{
      try{
      
    // Future<void> getImageFromLibrary() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
   File(pickedFile!.path);
  // }
  emit(ImageState());
      }catch(e){

      }
    });
  }
}
