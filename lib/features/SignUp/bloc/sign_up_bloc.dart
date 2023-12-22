import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:icomm/features/SignUp/model/user_model.dart';
import 'package:icomm/net/flutterfire.dart';
import 'package:meta/meta.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpInitialEvent>(signUpInitialEvent);
    on<SignInScreenNavigateButtonClicked>(signInScreenNavigateButtonClicked);
    on<SignUpButtonClicked>(signUpButtonClicked);
  }

  FutureOr<void> signUpInitialEvent(
      SignUpInitialEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }

  FutureOr<void> signInScreenNavigateButtonClicked(
      SignInScreenNavigateButtonClicked event, Emitter<SignUpState> emit) {
    emit(SignInScreenNavigateState());
  }

  FutureOr<void> signUpButtonClicked(
      SignUpButtonClicked event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    UserModel user = event.userModel;
    final response = await register(user.email, user.password, user.userName);
    //Response will be true, if account is successfully created, else it wil return the error code from firebase
    if (response == true) {
      emit(HomeScreenNavigateState());
    } else if (response == "weak-password") {
      emit(WeakPasswordErrorState());
    } else if (response == "email-already-in-use") {
      emit(EmailAlreadyInUseErrorState());
    } else {
      emit(SignUpErrorState());
    }
  }
}
