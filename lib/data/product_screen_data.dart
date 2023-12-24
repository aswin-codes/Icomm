import 'package:icomm/features/Home/model/category_model.dart';
import 'package:icomm/features/Home/model/product_model.dart';

ProductModel productData = ProductModel(
    name: "Sleek Rubber Pizza",
    price: 407,
    imageUrl: [
      "https://i.imgur.com/cHddUCu.jpeg",
      "https://i.imgur.com/CFOjAgK.jpeg",
      "https://i.imgur.com/wbIMMme.jpeg"
    ],
    description:
        "The beautiful range of Apple Naturalé that has an exciting mix of natural ingredients. With the Goodness of 100% Natural Ingredients",
    category: CategoryModel(
        categoryId: 1, categoryName: "Clothes", isSelected: false),
    productId: 1);
