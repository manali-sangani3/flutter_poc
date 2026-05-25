import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;

import '../model/product_model.dart';

// StateNotifier: Used for complex business logic and immutable state updates.
//
// Similar to Cubit/BLoC.
class CartNotifier extends StateNotifier<List<ProductModel>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    final exists = state.any((e) => e.id == product.id);

    if (exists) {
      state = state.map((item) {
        if (item.id == product.id) {
          item.quantity++;
        }

        return item;
      }).toList();
    } else {
      product.quantity = 1;

      state = [...state, product]; // Create a new list with old items + new product
    }
  }

  void removeFromCart(int id) {
    state = state.where((e) => e.id != id).toList();
  }
}

// used to manage and expose state from a StateNotifier.
final cartProvider = StateNotifierProvider<CartNotifier, List<ProductModel>>((
  ref,
) {
  return CartNotifier();
});
