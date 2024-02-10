part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}
class intialEvent extends SettingEvent{}
class LogoutEvent extends SettingEvent{}
class HomePageEvent extends SettingEvent{}