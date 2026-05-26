import 'package:hive/hive.dart';

class CacheService {

  final box = Hive.box(
    'productsBox',
  );

  /// SAVE CACHE
  Future<void> cacheProducts(
      String data,
      ) async {

    await box.put(
      'products',
      data,
    );
  }

  /// GET CACHE
  String? getCachedProducts() {

    return box.get(
      'products',
    );
  }
}