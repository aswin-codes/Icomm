part of 'splash_screen_bloc.dart';

@immutable
sealed class SplashScreenState {}

abstract class SplashScreenActionState extends SplashScreenState {}

final class SplashScreenInitial extends SplashScreenState {}

class NavigateToSignInScreenState extends SplashScreenActionState {}
