import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/total_provider.dart';

class TotalSection extends ConsumerWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalPriceProvider);

    return Container(
      padding: const EdgeInsets.all(20),

      child: Text(
        "Total: ₹$total",

        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
