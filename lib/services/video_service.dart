import 'package:video_player/video_player.dart';

class VideoService {

  late VideoPlayerController
      controller;

  Future<void> initialize(
    String url,
  ) async {

    controller =
        VideoPlayerController
            .networkUrl(
      Uri.parse(url),
    );

    await controller.initialize();
  }

  void dispose() {
    controller.dispose();
  }
}