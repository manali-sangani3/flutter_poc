import 'package:flutter/material.dart';

import '../repository/crypto_repository.dart';
import '../services/graphql_service.dart';
import '../services/websocket_service.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  late final CryptoRepository repository;

  List<dynamic> posts = [];

  bool isLoading = true;

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    repository = CryptoRepository(
      graphql: GraphqlService(),

      socket: WebSocketService(),
    );

    // repository.socket.connect();

    loadPosts();
  }

  Future<void> loadPosts() async {
    try {
      final data = await repository.graphql.fetchPosts();

      setState(() {
        posts = data;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    repository.socket.dispose();

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Crypto Tracker")),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                /// LIVE STREAM
                StreamBuilder(
                  stream: repository.socket.stream,

                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 12,right: 12),
                      child: Text(
                        snapshot.data?.toString() ?? "No Data",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    );
                  },
                ),

                /// MUTATION
                Padding(
                  padding: const EdgeInsets.all(12),

                  child: TextField(
                    controller: controller,

                    decoration: const InputDecoration(
                      hintText: "Websocket Message",

                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  child: ElevatedButton(
                    onPressed: () {
                      final result = repository.socket.sendMessage(
                        controller.text,
                      );

                      if (!context.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sent message to websocket: $result'),
                        ),
                      );

                      controller.clear();
                    },

                    child: const Text("Send"),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "GraphQL Query Data",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,

                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.currency_bitcoin),
                        ),

                        title: Text(post['title']),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
