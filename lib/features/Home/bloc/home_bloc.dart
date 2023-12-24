import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:icomm/data/home_screen_data.dart';
import 'package:icomm/data/product_screen_data.dart';
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
    on<CategoryChangedEvent>(categoryChangedEvent);
    on<ProductClickedEvent>(productClickedEvent);
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
      allProductList = tempList;

      //Request to get the list of categories available
      final responseCategory = await http
          .get(Uri.parse("https://api.escuelajs.co/api/v1/categories"));
      List<dynamic> respBodyCat = await jsonDecode(responseCategory.body);
      List<CategoryModel> tempListCat = <CategoryModel>[];
      print(respBodyCat);
      respBodyCat.forEach((element) {
        if (!isAlreadyAdded(element)) {
          tempListCat.add(CategoryModel(
              categoryId: element['id'],
              categoryName: element['name'],
              isSelected: false));
        }
      });
      categoryList = categoryList + tempListCat;
      emit(HomeSuccessfullyFetchedProductsState());
    } catch (e) {
      print(e);
      emit(HomeErrorFetchingProductsState());
    }
  }

  FutureOr<void> logOutButtonClickedEvent(
      LogOutButtonClickedEvent event, Emitter<HomeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    emit(LogOutButtonClickedState());
  }

  List<CategoryModel> updateCategoryList(
      List<CategoryModel> categoryList, int selectedCategoryId) {
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].categoryId == selectedCategoryId) {
        categoryList[i] = CategoryModel(
          categoryId: categoryList[i].categoryId,
          categoryName: categoryList[i].categoryName,
          isSelected: true,
        );
      } else {
        categoryList[i] = CategoryModel(
          categoryId: categoryList[i].categoryId,
          categoryName: categoryList[i].categoryName,
          isSelected: false,
        );
      }
    }
    return categoryList;
  }

  bool isAlreadyAdded(Map<String, dynamic> ele) {
    //bool isThere = false;
    for (int i = 0; i < categoryList.length; i++) {
      if ((categoryList[i].categoryName == ele['name']) ||
          ele['name'] == "Softech") {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> categoryChangedEvent(
      CategoryChangedEvent event, Emitter<HomeState> emit) {
    CategoryModel category = event.category;
    categoryList = updateCategoryList(categoryList, category.categoryId);
    if (category.categoryId == 0) {
      productList = allProductList;
    } else {
      productList = allProductList
          .where(
              (element) => element.category.categoryId == category.categoryId)
          .toList();
    }
    emit(HomeSuccessfullyFetchedProductsState());
  }

  FutureOr<void> productClickedEvent(
      ProductClickedEvent event, Emitter<HomeState> emit) {
    productData = event.product;
    emit(ProductClickedState());
  }
}
