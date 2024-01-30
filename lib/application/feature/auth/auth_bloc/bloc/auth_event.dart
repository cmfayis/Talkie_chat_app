// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckLoginStatusEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String phone;
  final String name;
  SignupEvent({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });
}

class GoogleButtonEvent extends AuthEvent {}

class LoginButtonClickedEvent extends AuthEvent {}

class SignUpButtonClickedEvent extends AuthEvent {}

class SignOutButtonEvent extends AuthEvent {}
