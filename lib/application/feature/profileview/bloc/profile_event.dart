part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ImageButtonEvent extends ProfileEvent{}
class SumbitEvent extends ProfileEvent{}
class ImageStoregeEvent extends ProfileEvent{
  final uid;
  final image;
  ImageStoregeEvent({required this.image,required this.uid});
}

