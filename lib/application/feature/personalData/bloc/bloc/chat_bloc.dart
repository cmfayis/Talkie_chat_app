import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

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
      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          emit(GalleryImagesState());
        } else {
          // emit(ImageErrorState(error: 'Please select an image.'));
        }
      } catch (e) {
        // emit(ImageErrorState(error: 'Error picking image: $e'));
        print(e.toString());}
    });
  }
}
