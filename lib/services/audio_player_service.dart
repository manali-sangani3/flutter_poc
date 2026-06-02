import 'package:just_audio/just_audio.dart';

class AudioService {

  final AudioPlayer player =
      AudioPlayer();

  Future<void> loadAudio(
    String url,
  ) async {

    await player.setUrl(url);
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> seek(
    Duration position,
  ) async {
    await player.seek(position);
  }

  void dispose() {
    player.dispose();
  }
}