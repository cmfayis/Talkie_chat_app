part of 'status_bloc.dart';

@immutable
sealed class StatusEvent {}
class ColorPick extends StatusEvent{}
class ColorPickerEvent extends StatusEvent{
  Color color;
  ColorPickerEvent({required this.color});
}