import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:icomm/data/home_screen_data.dart';
import 'package:icomm/features/Home/model/category_model.dart';
import 'package:icomm/features/Home/model/product_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<LogOutButtonClickedEvent>(logOutButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = await prefs.getString("userName")!;
    try {
      //Request to get the list of all products and storing that in productList
      final response = await http
          .get(Uri.parse("https://api.escuelajs.co/api/v1/products/"));
      List<dynamic> respBody = await jsonDecode(response.body);
      List<ProductModel> tempList = <ProductModel>[];
      respBody.forEach((element) {
        tempList.add(ProductModel(
            name: element["title"],
            price: element["price"].toDouble(),
            imageUrl: element["images"],
            description: element["description"],
            category: CategoryModel(
                categoryId: element["category"]["id"],
                categoryName: element["category"]["name"],
                isSelected: false),
            productId: element['id']));
      });
      productList = tempList;

      //Request to get the list of categories available
      final responseCategory = await http
          .get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));
      List<dynamic> respBodyCat = await jsonDecode(responseCategory.body);
      respBodyCat.forEach((element) {
        categoryList.add(CategoryModel(
            categoryId: element['id'],
            categoryName: element['name'],
            isSelected: false));
      });
      emit(HomeSuccessfullyFetchedProductsState());
    } catch (e) {
      emit(HomeErrorFetchingProductsState());
    }
  }

  FutureOr<void> logOutButtonClickedEvent(
      LogOutButtonClickedEvent event, Emitter<HomeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    emit(LogOutButtonClickedState());
  }
}
