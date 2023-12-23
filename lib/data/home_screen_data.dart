import 'package:icomm/features/Home/model/category_model.dart';
import 'package:icomm/features/Home/model/product_model.dart';

String userName = '';
List<ProductModel> productList = <ProductModel>[];
List<ProductModel> allProductList = <ProductModel>[];

List<CategoryModel> categoryList = <CategoryModel>[
  CategoryModel(categoryId: 0, categoryName: "All", isSelected: true),
];
