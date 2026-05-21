import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';

final productsProvider =
// Handles async operations automatically.
FutureProvider<List<ProductModel>>((
    ref,
    ) async {

  await Future.delayed(
    const Duration(seconds: 2),
  );

  return [
    ProductModel(
      id: 1,
      name: "Laptop",
      price: 70000,
      category: "Electronics",
    ),

    ProductModel(
      id: 2,
      name: "Shoes",
      price: 3000,
      category: "Fashion",
    ),

    ProductModel(
      id: 3,
      name: "Watch",
      price: 5000,
      category: "Accessories",
    ),
  ];
});