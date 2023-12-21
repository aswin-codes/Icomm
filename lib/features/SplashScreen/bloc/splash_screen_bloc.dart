import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<SplashScreenInitialEvent>(splashScreenInitialEvent);
    on<SignInScreenNavigateEvent>(signInScreenNavigateEvent);
  }

  FutureOr<void> splashScreenInitialEvent(
      SplashScreenInitialEvent event, Emitter<SplashScreenState> emit) {
    emit(SplashScreenInitial());
  }

  FutureOr<void> signInScreenNavigateEvent(
      SignInScreenNavigateEvent event, Emitter<SplashScreenState> emit) {
    emit(NavigateToSignInScreenState());
  }
}
