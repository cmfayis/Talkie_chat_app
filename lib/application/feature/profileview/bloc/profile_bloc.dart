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
  
      
    // Future<void> getImageFromLibrary() async {
    
  emit(ImageState());
    });
  }
}
