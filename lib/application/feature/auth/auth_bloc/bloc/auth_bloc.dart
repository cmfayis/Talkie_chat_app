import 'package:bloc/bloc.dart';
import 'package:chat_app/application/feature/auth/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<SignupEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          final userCredential = await auth.createUserWithEmailAndPassword(
            email: event.user.email.toString(),
            password: event.user.password.toString(),
          );
          final user = userCredential.user;
          if (user != null) {
            FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              'Name': event.user.name,
              'Email': event.user.email,
              "phone": event.user.phone,
              'CreatAt': DateTime.now(),
            });
            emit(AuthenticatedState(user: user));
          } else {
            emit(UnAuthenticatedState());
          }
        } catch (e) {
          emit(ErrorAuthenctionState(error: e.toString()));
        }
      },
    );
    on<LoginEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        try {
          final UserCredential = await auth.signInWithEmailAndPassword(
              email: event.user.email.toString(),
              password: event.user.password.toString());
          final user = UserCredential.user;
          if (user != null) {
            emit(AuthenticatedState(user: user));
          } else {
            emit(UnAuthenticatedState());
          }
        } catch (e) {
          emit(ErrorAuthenctionState(error: e.toString()));
        }
      },
    );
    on<SignUpButtonClickedEvent>((event, emit) {
      emit(SignUpButtonClickedState());
    });
    on<LoginButtonClickedEvent>((event, emit) {
      emit(LoginButtonClickedState());
    });
    on<CheckLoginStatusEvent>((event, emit) async {
      User? user;
      try {
        await Future.delayed(Duration(seconds: 2), () {
          user = auth.currentUser;
        });
        if (user != null) {
          emit(AuthenticatedState(user: user));
        } else {
          emit(UnAuthenticatedState());
        }
      } catch (e) {
        emit(ErrorAuthenctionState(error: e.toString()));
      }
    });
  }
}
