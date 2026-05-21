import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_provider.dart';

final totalPriceProvider =
Provider<double>((ref) {

  final cart = ref.watch(cartProvider);

  double total = 0;

  for (var item in cart) {
    total += item.price * item.quantity;
  }

  return total;
});