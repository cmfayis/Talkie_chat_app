part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final int  tabIndex;

  HomeState({required this.tabIndex});
}

final class HomeInitial extends HomeState {
  HomeInitial({required super.tabIndex});
}