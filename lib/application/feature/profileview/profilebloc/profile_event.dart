part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ImageButtonEvent extends ProfileEvent{}
class SumbitEvent extends ProfileEvent{}
class SkipEvent extends ProfileEvent{}
