
part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}
class ActionState extends AuthState{}
final class AuthInitial extends AuthState {}
class AuthLoadingState extends AuthState{}
class AuthenticatedState extends AuthState{
}
class UnAuthenticatedState extends AuthState{}
class ErrorAuthenctionState extends AuthState {
  final String error;
  ErrorAuthenctionState({
    required this.error,
  });
}
class LoginButtonClickedState extends ActionState{}
class SignUpButtonClickedState extends ActionState{}
class GoogleButtonState extends ActionState{}