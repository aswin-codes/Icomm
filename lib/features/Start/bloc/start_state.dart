part of 'start_bloc.dart';

@immutable
sealed class StartState {}

final class StartInitial extends StartState {}

class HomeScreenNavigateState extends StartState {}

class SplashScreenNavigateState extends StartState {}
