part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendEvent extends ChatEvent {
  final friendId;
  final message;
  final currentId;
  SendEvent(
      {required this.message, required this.currentId, required this.friendId});
}

class FileSendEvent extends ChatEvent {}

class GalleryImagesEvent extends ChatEvent {}

class CameraImagesEvent extends ChatEvent {}

class LocationEvent extends ChatEvent {
  final currentId;
  final friendId;
  LocationEvent({required this.currentId, required this.friendId});
}

class ShowImageEvent extends ChatEvent {}

class SendImageEvent extends ChatEvent {
  File image;
  final currentId;
  final friendId;
  SendImageEvent(
      {required this.currentId, required this.friendId, required this.image});
}
