import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {
  /// CLIENT
  final client = GraphQLClient(
    cache: GraphQLCache(),

    link: HttpLink('https://graphqlzero.almansi.me/api'),
  );

  Future<List<dynamic>> fetchPosts() async {
    const query = r'''
      query{
  posts{
    data{
    id
      title
      body
    }
    
  }
}
    ''';

    final result = await client.query(QueryOptions(document: gql(query)));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['posts']['data'];
  }

  /// MUTATION
  Future<Map<String, dynamic>> createPost(String title) async {
    const mutation = r'''
      mutation(
        $title: String!
      ) {
        createPost(
          input: {
            title: $title,
            body: "Flutter GraphQL Demo"
          }
        ) {
          id
          title
          body
        }
      }
    ''';

    final result = await client.mutate(
      MutationOptions(document: gql(mutation), variables: {'title': title}),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result.data?['createPost'];
  }
}
