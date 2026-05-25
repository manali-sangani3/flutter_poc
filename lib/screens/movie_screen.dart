import 'package:flutter/material.dart';

import '../model/shop_model.dart';
import '../repository/movie_repository.dart';
import '../services/graphql_service.dart';
import '../services/rest_api_service.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late final MovieRepository repository;

  bool isLoading = true;

  List<ShopModel> movies = [];

  List<dynamic> countries = [];

  String error = '';

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    repository = MovieRepository(
      restApi: RestApiService(),

      graphql: GraphqlService(),
    );

    loadData();
  }

  Future<void> loadData() async {
    try {
      final movieData = await repository.fetchMovies();

      final countryData = await repository.fetchCountries();

      setState(() {
        movies = movieData;

        countries = countryData;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Explorer")),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
          ? Center(child: Text(error))
          : ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),

                  child: Text(
                    "REST API Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                ...movies.map((movie) {
                  return ListTile(
                    leading: Image.network(movie.thumbnail, width: 50),

                    title: Text(movie.title),
                  );
                }),

                const Padding(
                  padding: EdgeInsets.all(12),

                  child: Text(
                    "GraphQL Mutation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  child: TextField(
                    controller: controller,

                    decoration: const InputDecoration(
                      hintText: "Enter Post Title",

                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final response = await repository.graphql.createPost(
                          controller.text,
                        );

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Created: ${response['title']}'),
                          ),
                        );

                        controller.clear();
                      } catch (e) {
                        print(e.toString());
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },

                    child: const Text("Create GraphQL Post"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),

                  child: Text(
                    "GraphQL Query",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ...countries.take(10).map((country) {
                  return ListTile(
                    title: Text(country['title']),
                    subtitle: Text(country['body']),
                  );
                }),
              ],
            ),
    );
  }
}
