import '../model/shop_model.dart';
import '../services/graphql_service.dart';
import '../services/rest_api_service.dart';

class MovieRepository {
  final RestApiService restApi;

  final GraphqlService graphql;

  MovieRepository({required this.restApi, required this.graphql});

  Future<List<ShopModel>> fetchMovies() {
    return restApi.fetchMovies();
  }

  Future<List<dynamic>> fetchCountries() {
    return graphql.fetchCountries();
  }
}
