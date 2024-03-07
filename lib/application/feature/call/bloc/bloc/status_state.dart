part of 'status_bloc.dart';

@immutable
sealed class StatusState {}

final class StatusInitial extends StatusState {}
class ColorPickState extends StatusState{}
class ColorPickerState extends StatusState{
  Color color;
  ColorPickerState({required this.color});
}