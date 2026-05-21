import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';
import '../provider/cart_provider.dart';

class ProductTile extends ConsumerWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(product.name),

      subtitle: Text("₹${product.price}"),

      trailing: IconButton(
        onPressed: () {
          // Reads provider without rebuilding.
          ref.read(cartProvider.notifier).addToCart(product);
        },

        icon: Icon(Icons.add),
      ),
    );
  }
}
