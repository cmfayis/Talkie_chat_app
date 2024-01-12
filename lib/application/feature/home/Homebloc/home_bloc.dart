import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(tabIndex: 0)) {
    on<HomeEvent>((event, emit) {
        if (event is TabChangeEvent) {
        emit(HomeInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
