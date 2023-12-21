import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:icomm/features/SignIn/model/user_model.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInInitialEvent>(signInInitialEvent);
  }

  FutureOr<void> signInInitialEvent(
      SignInInitialEvent event, Emitter<SignInState> emit) {
    emit(SignInInitial());
  }
}
