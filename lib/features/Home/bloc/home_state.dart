part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessfullyFetchedProductsState extends HomeState {}

class HomeErrorFetchingProductsState extends HomeState {}

class LogOutButtonClickedState extends HomeActionState {}
