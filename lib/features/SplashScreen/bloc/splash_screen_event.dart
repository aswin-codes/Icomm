part of 'splash_screen_bloc.dart';

@immutable
sealed class SplashScreenEvent {}

class SplashScreenInitialEvent extends SplashScreenEvent {}

class SignInScreenNavigateEvent extends SplashScreenEvent {}
