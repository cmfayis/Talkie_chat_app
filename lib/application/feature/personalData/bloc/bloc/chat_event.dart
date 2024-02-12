part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendEvent extends ChatEvent {
  final friendId;
  final message;
  final currentId;
  SendEvent({
    required this.message,
    required this.currentId, required this.friendId});
}
class FileSendEvent extends ChatEvent{}
