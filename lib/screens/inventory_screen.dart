import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/product_provider.dart';
import '../widgets/product_tile.dart';
import '../widgets/total_section.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref /* Used to access providers.*/) {
    final products = ref.watch(productsProvider); // Listens to provider changes and rebuilds UI.

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod Inventory")),

      body: Column(
        children: [
          // AsyncValue?
          //
          // Represents:
          //
          // loading
          // data
          // error
          //
          // states safely.
          Expanded(
            child: products.when(
              data: (items) {
                return ListView.builder(
                  itemCount: items.length,

                  itemBuilder: (context, index) {
                    return ProductTile(product: items[index]);
                  },
                );
              },

              loading: () => const Center(child: CircularProgressIndicator()),

              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),

          const TotalSection(),
        ],
      ),
    );
  }
}
