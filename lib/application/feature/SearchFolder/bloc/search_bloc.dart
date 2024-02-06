import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/application/feature/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Map> searchResult = [];
  SearchBloc() : super(SearchInitial()) {
    on<CurrentUserRequested>(currentUserRequested);
    on<PerformSearchEvent>(performSearchEvent);
  }

  FutureOr<void> performSearchEvent(
      PerformSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .where("Name", isEqualTo: event.searchText)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          emit(SearchUserNotFound(message: "No user Found"));
        } else {
          for (var user in value.docs) {
            searchResult.add(user.data());
          }
          emit(SearchLoaded(searchResult: searchResult));
        }
      });
    } catch (e) {
      emit(SearchError(error: "Error searching: $e"));
    }
  }

  FutureOr<void> currentUserRequested(
      CurrentUserRequested event, Emitter<SearchState> emit) async{
        try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        final userModel = UserModel.fromJson(userData);
        emit(CurrentUserLoaded(userModel: userModel));
      } else {
        emit(CurrentUserNotFound());
      }
    } catch (e) {
      emit(SearchError(error: "Error getting current user: $e"));
    }
      }
}