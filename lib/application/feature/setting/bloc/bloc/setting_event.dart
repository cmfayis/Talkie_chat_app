part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}
class intialEvent extends SettingEvent{}
class LogoutEvent extends SettingEvent{}
class HomePageEvent extends SettingEvent{}
class ProfileEditEvent extends SettingEvent{}
class BackButtonEvent extends SettingEvent{}
class UpdateDataEvent extends SettingEvent{
  String Data ;
  UpdateDataEvent({required this.Data});
}