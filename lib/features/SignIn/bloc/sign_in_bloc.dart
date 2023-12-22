import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:icomm/features/SignIn/model/user_credential_model.dart';
import 'package:icomm/net/flutterfire.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInInitialEvent>(signInInitialEvent);
    on<SignUpNavigateButtonClicked>(signUpNavigateButtonClicked);
    on<SignInButtonClickedEvent>(signInButtonClickedEvent);
  }

  FutureOr<void> signInInitialEvent(
      SignInInitialEvent event, Emitter<SignInState> emit) {
    emit(SignInInitial());
  }

  FutureOr<void> signUpNavigateButtonClicked(
      SignUpNavigateButtonClicked event, Emitter<SignInState> emit) {
    emit(NavigateToSignUpScreenState());
  }

  FutureOr<void> signInButtonClickedEvent(
      SignInButtonClickedEvent event, Emitter<SignInState> emit) async {
    UserCredential userCredential = event.userCredential;
    emit(SignInLoadingState());
    //Responce will be true if the user entered correct email and password else false
    final response =
        await signIn(userCredential.email, userCredential.password);
    if (response) {
      //If the response is true navigating to home screen
      emit(NavigateToHomeScreenState());
      
    } else {
      emit(SignInErrorState());
    }
  }
}
