import 'package:bloc/bloc.dart';
import 'package:chat_app/application/feature/auth/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth=FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
   on<CheckLoginStatusEvent>((event, emit) async{
      User? user;
      try{
        await Future.delayed(Duration(seconds: 2),(){
          user=auth.currentUser;
        });
        if(user!=null){
          emit(AuthenticatedState(user: user));
        }else{
          emit(UnAuthenticatedState());
        }
      } 
      catch (e){
        emit(ErrorAuthenctionState(error: e.toString()));
      }
   });
  }
}
