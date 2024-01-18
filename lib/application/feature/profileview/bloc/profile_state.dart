// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
 
class ImageSuccessState extends ProfileState {
  File image;
  ImageSuccessState({
    required this.image,
  });
 }
class ImageErrorState extends ProfileState {
  String error;
  ImageErrorState({
    required this.error,
  });
 }
 class SubmitState extends ProfileState{}
