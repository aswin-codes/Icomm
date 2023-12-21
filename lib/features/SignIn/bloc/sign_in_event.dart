part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SignInInitialEvent extends SignInEvent {}

class SignInButtonClickedEvent extends SignInEvent {
  final UserModel user;
  SignInButtonClickedEvent({required this.user});
}

class SignUpNavigateButtonClicked extends SignInState {}
