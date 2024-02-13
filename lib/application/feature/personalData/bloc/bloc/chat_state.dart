part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
 class FileSendState extends ChatState{}
 class GalleryImagesState extends ChatState{}
 class GalleryImageSentSuccessState extends ChatState{}