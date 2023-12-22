import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'start_event.dart';
part 'start_state.dart';

class StartBloc extends Bloc<StartEvent, StartState> {
  StartBloc() : super(StartInitial()) {
    on<StartInitialEvent>(startInitialEvent);
  }

  FutureOr<void> startInitialEvent(
      StartInitialEvent event, Emitter<StartState> emit) async {
    emit(StartInitial());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isUserLoggedIn = await prefs.getBool("isUserLoggedIn");
    if (isUserLoggedIn == true) {
      emit(HomeScreenNavigateState());
    } else {
      emit(SplashScreenNavigateState());
    }
  }
}
