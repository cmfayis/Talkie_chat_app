import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  List<Map> searchResult = [];
  SettingBloc() : super(SettingInitial()) {
    on<intialEvent>((event, emit)async{
      User? user = FirebaseAuth.instance.currentUser;
       QuerySnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: user!.uid)
          .get();
           if (userData.docs.isNotEmpty) {
        
        final name=userData.docs.last.get('Name');
        final  imageUrl = userData.docs.last.get('image');
        emit(FetchState(name: name, iamgeUrl: imageUrl));
      }
    });
    on<LogoutEvent>((event, emit) {
    FirebaseAuth.instance.signOut();
    emit(LogoutState());
    });
    on<HomePageEvent>((event, emit) {
      emit(HomePageState());
    });
  }
}
