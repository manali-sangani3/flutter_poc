import 'package:flutter_poc/model/product_model.dart';
import 'package:flutter_poc/provider/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Riverpod Tests', () {
    test('Product added to cart', () {
      final container = ProviderContainer();

      final notifier = container.read(cartProvider.notifier);

      notifier.addToCart(
        ProductModel(
          id: 1,
          name: "Laptop",
          price: 1000,
          category: "Electronics",
        ),
      );

      expect(container.read(cartProvider).length, 1);
    });
  });
}
