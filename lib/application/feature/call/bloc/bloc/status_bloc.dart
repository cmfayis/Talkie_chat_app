import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StatusBloc() : super(StatusInitial()) {
    on<ColorPick>((event, emit) {
      emit(ColorPickState());
    });
    on<ColorPickerEvent>((event, emit) {
      emit(ColorPickerState(color: event.color));
    });
  }
}
