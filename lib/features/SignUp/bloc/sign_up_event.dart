part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpInitialEvent extends SignUpEvent {}

class SignInScreenNavigateButtonClicked extends SignUpEvent {}

class SignUpButtonClicked extends SignUpEvent {
  UserModel userModel;
  SignUpButtonClicked({required this.userModel});
}
