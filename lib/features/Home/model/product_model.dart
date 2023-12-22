import 'package:icomm/features/Home/model/category_model.dart';

class ProductModel {
  String name;
  double price;
  List<dynamic> imageUrl;
  String description;
  int productId;
  CategoryModel category;
  ProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.productId,
  });
}
