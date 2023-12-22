part of 'start_bloc.dart';

@immutable
sealed class StartEvent {}

class StartInitialEvent extends StartEvent {}
