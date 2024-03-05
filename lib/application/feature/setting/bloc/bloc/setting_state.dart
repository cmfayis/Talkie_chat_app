// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'setting_bloc.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

class FetchState extends SettingState {
  final String name;
  final String imageUrl;
  final String email;

  FetchState({
    required this.email,
    required this.name,
    required this.imageUrl,
  });
}

class LogoutState extends SettingState {}

class HomePageState extends SettingState {}
class ProfileEditState extends SettingState{}
class BackState extends SettingState{}
class UpdateState extends SettingState{
  String name;
  UpdateState({required this.name});
}
class NavigateToProfileState extends SettingState{}