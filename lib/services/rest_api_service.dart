import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/shop_model.dart';
import 'auth_service.dart';
import 'cache_service.dart';

class RestApiService {
  final authService = AuthService();
  final cacheService = CacheService();

  Future<List<ShopModel>> fetchMovies() async {
    try {
      /// Simulate expired token
      if (authService.accessToken == "expired_token") {
        print("Token expired...");

        /// Refresh token
        await authService.refreshAccessToken();

        print("Token refreshed");
      }

      /// ONLINE FETCH
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
        headers: {'Authorization': 'Bearer ${authService.accessToken}'},
      );

      if (response.statusCode == 200) {
        /// SAVE CACHE
        await cacheService.cacheProducts(response.body);
        final data = jsonDecode(response.body);

        final products = data['products'] as List;

        return products.map((json) {
          return ShopModel(
            id: json['id'],

            title: json['title'],

            thumbnail: json['thumbnail'],
          );
        }).toList();
      }

      throw Exception("Failed to fetch movies");
    } catch (e) {
      print("Loading from Hive cache...");

      /// LOAD CACHE
      final cachedData = cacheService.getCachedProducts();

      if (cachedData != null) {
        final data = jsonDecode(cachedData);

        final products = data['products'] as List;

        return products.map((json) {
          return ShopModel(
            id: json['id'],

            title: json['title'],

            thumbnail: json['thumbnail'],
          );
        }).toList();
      }

      throw Exception("No Internet & No Cache");
    }
  }
}
