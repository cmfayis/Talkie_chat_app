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

class GalleryImagesEvent extends ChatEvent {
  final currentId;
  final friendId;
  GalleryImagesEvent({required this.currentId, required this.friendId});
}

class CameraImagesEvent extends ChatEvent {
  final currentId;
  final friendId;
  CameraImagesEvent({required this.currentId, required this.friendId});
}
class LocationEvent extends ChatEvent {
  final currentId;
  final friendId;
LocationEvent({required this.currentId, required this.friendId});
}

class ShowImageEvent extends ChatEvent{
}