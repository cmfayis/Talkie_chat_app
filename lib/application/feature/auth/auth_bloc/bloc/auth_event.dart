// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckLoginStatusEvent extends AuthEvent{}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;
  LoginEvent({required this.email,required this.password});
}
class SignupEvent extends AuthEvent {
  UserModel user;
  SignupEvent({
    required this.user,
  });
}
