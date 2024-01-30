part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Map> searchResult;
  SearchLoaded({
    required this.searchResult,
  });
}

class SearchUserNotFound extends SearchState {
  final String message;
  SearchUserNotFound({
    required this.message,
  });
}

class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});
}

class CurrentUserLoaded extends SearchState {
  final UserModel userModel;
  CurrentUserLoaded({
    required this.userModel,
  });
}

class CurrentUserNotFound extends SearchState {}