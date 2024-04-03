part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class FileSendState extends ChatState {}

class GalleryImagesState extends ChatState {}

class GalleryImageSentSuccessState extends ChatState {
  File ImageUrl;
  GalleryImageSentSuccessState({required this.ImageUrl});
}

class ShowImagesState extends ChatState {}

class SendImageState extends ChatState {}

class LodingImageState extends ChatState {}
