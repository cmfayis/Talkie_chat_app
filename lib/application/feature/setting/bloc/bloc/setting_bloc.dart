import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  List<Map> searchResult = [];
  SettingBloc() : super(SettingInitial()) {
    User? user = FirebaseAuth.instance.currentUser;
    on<NavigateToProfileEvent>((event, emit) {
      emit(NavigateToProfileState());
    });
    on<UpdateDataEvent>((event, emit) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'Name': event.Data,
      });
      emit(UpdateState(name: event.Data));
    });
    on<BackButtonEvent>((event, emit) {
      emit(BackState());
    });
    on<ProfileEditEvent>((event, emit) {
      emit(ProfileEditState());
    });
    on<intialEvent>((event, emit) async {
      // emit(LoadingState());
      User? user = FirebaseAuth.instance.currentUser;
      QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection("users")
          .where("uid", isEqualTo: user!.uid)
          .get();
      if (userData.docs.isNotEmpty) {
        final email = userData.docs.last.get('Email');
        final name = userData.docs.last.get('Name');
        final imageUrl = userData.docs.last.get('image');

        emit(FetchState(
          name: name,
          imageUrl: imageUrl,
          email: email,
        ));
      }
    });
    on<LogoutEvent>((event, emit) {
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      emit(LogoutState());
    });
    on<HomePageEvent>((event, emit) {
      emit(HomePageState());
    });
  }
}
