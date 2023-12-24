part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class CategoryChangedEvent extends HomeEvent {
  CategoryModel category;
  CategoryChangedEvent({required this.category});
}

class LogOutButtonClickedEvent extends HomeEvent {}

class ProductClickedEvent extends HomeEvent {
  ProductModel product;
  ProductClickedEvent({required this.product});
}
