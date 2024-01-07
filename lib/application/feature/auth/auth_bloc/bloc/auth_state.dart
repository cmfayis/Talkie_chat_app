
part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class AuthLoadingState extends AuthState{}
class AuthenticatedState extends AuthState{
  User? user;
  AuthenticatedState({ this.user});
}
class UnAuthenticatedState extends AuthState{}
class ErrorAuthenctionState extends AuthState {
  final String error;
  ErrorAuthenctionState({
    required this.error,
  });
}
