import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/shop_model.dart';

class RestApiService {
  Future<List<ShopModel>> fetchMovies() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );

    if (response.statusCode == 200) {
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
  }
}
