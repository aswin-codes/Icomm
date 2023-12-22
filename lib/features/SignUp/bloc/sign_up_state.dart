part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

abstract class SignUpActionState extends SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignInScreenNavigateState extends SignUpActionState {}

class SignUpLoadingState extends SignUpActionState {}

class HomeScreenNavigateState extends SignUpActionState {}

class WeakPasswordErrorState extends SignUpActionState {}

class EmailAlreadyInUseErrorState extends SignUpActionState {}

class SignUpErrorState extends SignUpActionState {}
