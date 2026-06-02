import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/model/media_item_model.dart';
import 'package:video_player/video_player.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key});

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  VideoPlayerController? videoController;

  ChewieController? chewieController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadVideo(videoPlaylist.first.url);
    // initializeVideo();
  }

  Future<void> loadVideo(String url) async {
    // Remove current player from UI
    final oldChewie = chewieController;
    final oldVideo = videoController;

    setState(() {
      chewieController = null;
      videoController = null;
    });

    oldChewie?.dispose();
    await oldVideo?.dispose();

    final newVideoController = VideoPlayerController.networkUrl(Uri.parse(url));

    await newVideoController.initialize();

    final newChewieController = ChewieController(
      videoPlayerController: newVideoController,
      autoPlay: true,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
    );

    if (!mounted) return;

    setState(() {
      videoController = newVideoController;

      chewieController = newChewieController;
    });
  }

  Future<void> initializeVideo() async {
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(videoPlaylist.first.url),
    );

    await videoController?.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoController!,

      autoPlay: false,

      looping: false,

      allowPlaybackSpeedChanging: true,

      allowFullScreen: true,
    );

    setState(() {});
  }

  @override
  void dispose() {
    chewieController?.dispose();

    videoController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController == null || videoController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [
          AspectRatio(
            aspectRatio: videoController!.value.aspectRatio,

            child: Chewie(controller: chewieController!),
          ),

          const SizedBox(height: 20),

          ValueListenableBuilder(
            valueListenable: videoController!,

            builder: (context, value, child) {
              return Column(
                children: [
                  Text(value.position.toString().split('.').first),

                  Slider(
                    value: value.position.inSeconds.toDouble(),

                    max: value.duration.inSeconds == 0
                        ? 1
                        : value.duration.inSeconds.toDouble(),

                    onChanged: (newValue) {
                      videoController?.seekTo(
                        Duration(seconds: newValue.toInt()),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videoPlaylist.length,

              itemBuilder: (context, index) {
                final item = videoPlaylist[index];

                return ListTile(
                  selected: selectedIndex == index,

                  title: Text(item.title),

                  leading: const Icon(Icons.video_library),

                  onTap: () async {
                    setState(() {
                      selectedIndex = index;
                    });

                    await loadVideo(item.url);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
