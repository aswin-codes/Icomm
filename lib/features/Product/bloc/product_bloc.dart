import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialEvent>(productInitialEvent);
  }

  FutureOr<void> productInitialEvent(
      ProductInitialEvent event, Emitter<ProductState> emit) {
    emit(ProductInitial());
  }
}
