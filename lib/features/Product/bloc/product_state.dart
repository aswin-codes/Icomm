part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

abstract class ProductActionState extends ProductState {}

final class ProductInitial extends ProductState {}

