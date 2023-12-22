part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SignInInitialEvent extends SignInEvent {}

class SignInButtonClickedEvent extends SignInEvent {
  final UserCredential userCredential;
  SignInButtonClickedEvent({required this.userCredential});
}

class SignUpNavigateButtonClicked extends SignInEvent {}
