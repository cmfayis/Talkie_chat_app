// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'setting_bloc.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}
class FetchState extends SettingState {
  final String name;
  final String iamgeUrl;
  FetchState({
    required this.name,
    required this.iamgeUrl,
  });
 
}
 class LogoutState extends SettingState{}
 class HomePageState extends SettingState{}