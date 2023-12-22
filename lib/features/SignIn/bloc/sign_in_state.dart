part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

abstract class SignInActionState extends SignInState {}

final class SignInInitial extends SignInState {}

class SignInErrorState extends SignInActionState {}

class SignInLoadingState extends SignInActionState {}

class NavigateToHomeScreenState extends SignInActionState {}

class NavigateToSignUpScreenState extends SignInActionState {}
