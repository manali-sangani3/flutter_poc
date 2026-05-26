import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.org'),
  );

  Stream get stream => channel.stream;

  String sendMessage(String message) {
    channel.sink.add(message);
    return message;
  }

  void dispose() {
    channel.sink.close();
  }
}
