import 'dart:async';
import 'package:bloc/bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() : super(HomeState()) {
    on<InitializeHomePage>(initialize);
    // on<ChangeTabEvent>(changeTab);

  }

  // FutureOr<void> changeTab(ChangeTabEvent event, Emitter<HomeState>emit) async {
  //   emit(state.copyWith(selectedIndex: event.idx));
  // }

  FutureOr<void> initialize(InitializeHomePage event, Emitter<HomeState> emit) {
  }
}
