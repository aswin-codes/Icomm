part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

abstract class SignInActionState extends SignInState {}

final class SignInInitial extends SignInState {}

class SignInErrorState extends SignInState {}

class NavigateToHomeScreenState extends SignInActionState {}

class NavigateToSignUpScreenState extends SignInActionState {}



