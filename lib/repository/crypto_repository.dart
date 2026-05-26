import '../services/graphql_service.dart';
import '../services/websocket_service.dart';

class CryptoRepository {

  final GraphqlService graphql;

  final WebSocketService socket;

  CryptoRepository({
    required this.graphql,
    required this.socket,
  });
}