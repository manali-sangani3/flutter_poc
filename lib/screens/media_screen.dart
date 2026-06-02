import 'package:flutter/material.dart';

import 'package:flutter_poc/widgets/audio_tab.dart';
import 'package:flutter_poc/widgets/video_tab.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Media Learning Hub',
          ),

          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.headphones),
                text: 'Audio',
              ),

              Tab(
                icon: Icon(Icons.video_library),
                text: 'Video',
              ),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            AudioTab(),
            VideoTab(),
          ],
        ),
      ),
    );
  }
}