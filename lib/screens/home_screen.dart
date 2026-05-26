import 'package:flutter/material.dart';

import '../model/topic_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TopicModel> demos = [
      TopicModel(title: "Core Dart & Programming", route: "/core-dart"),

      TopicModel(
        title: "Asynchronous & Concurrent Programming",
        route: "/async-programming",
      ),

      TopicModel(
        title: "Accessibility & Localization",
        route: "/accessibility",
      ),

      TopicModel(title: "Lifting State Up", route: "/counter"),
      TopicModel(
        title: "InheritedWidget & Context Propagation",
        route: "/settings",
      ),

      TopicModel(title: "Provider State Management", route: "/provider"),
      TopicModel(title: "Bloc/Cubit State Management", route: "/bloc"),
      TopicModel(title: "Riverpod State Management", route: "/riverpod"),
      TopicModel(title: "MobX State Management", route: "/mobx"),
      TopicModel(title: "Dependency Injection", route: "/dependency_injection"),
      TopicModel(title: "REST & GraphQL + Offline Handling & Caching", route: "/rest-graph"),
      TopicModel(title: "GraphQL & WebSocket", route: "/graph-websocket"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Upskilling"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },

            icon: AnimatedRotation(
              turns: 1,

              duration: const Duration(milliseconds: 500),

              curve: Curves.easeInOut,

              child: Icon(Icons.settings_rounded),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: demos.length,
        itemBuilder: (_, index) {
          final item = demos[index];

          return ListTile(
            title: Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              /// ----------------------------
              /// NAVIGATION & ROUTING
              /// ----------------------------
              ///
              /// Navigates using named routes
              ///
              Navigator.pushNamed(context, demos[index].route);
            },
          );
        },
      ),
    );
  }
}
