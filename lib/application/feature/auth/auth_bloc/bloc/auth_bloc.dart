import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            email: event.email,
            password: event.password,
          );
          final user = userCredential.user;
          if (user != null) {
            FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              'Name': event.name,
              'Email': event.email,
              "phone": event.phone,
              "uid": user.uid,
              'CreatAt': DateTime.now(),
            });
            emit(AuthenticatedState());
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
              email: event.email, password: event.password);
          final user = UserCredential.user;
          if (user != null) {
      //       DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      // UserModel userModel = UserModel.fromJson(userData);
            emit(AuthenticatedState());
          } else {
            emit(UnAuthenticatedState());
          }
        } catch (e) {
          emit(ErrorAuthenctionState(error: e.toString()));
        }
      },
    );
    on<SignOutButtonEvent>((event, emit) async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await auth.signOut();
      await googleSignIn.signOut();
      emit(UnAuthenticatedState());
    });
    on<GoogleButtonEvent>((event, emit) async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      try {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'Email': userCredential.user!.email,
            'Name': userCredential.user!.displayName,
            'image': userCredential.user!.photoURL,
            'uid': userCredential.user!.uid,
            'date': DateTime.now(),
          });
          emit(GoogleButtonState());
        }
      } on FirebaseAuthException {
        rethrow;
      }
    });
    on<SignUpButtonClickedEvent>((event, emit) {
      emit(SignUpButtonClickedState());
    });
    on<LoginButtonClickedEvent>((event, emit) {
      emit(LoginButtonClickedState());
    });
    on<CheckLoginStatusEvent>((event, emit) async {
      User? users;
      try {
        await Future.delayed(const Duration(seconds: 2), () {
          users = auth.currentUser;
        });
        if (users != null) {
     
          emit(AuthenticatedState());
        } else {
          emit(UnAuthenticatedState());
        }
      } catch (e) {
        emit(ErrorAuthenctionState(error: e.toString()));
      }
    });
  }
}
