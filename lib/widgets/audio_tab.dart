import 'package:flutter/material.dart';
import 'package:flutter_poc/model/media_item_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioTab extends StatefulWidget {
  const AudioTab({super.key});

  @override
  State<AudioTab> createState() => _AudioTabState();
}

class _AudioTabState extends State<AudioTab> {
  final player = AudioPlayer();

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  double speed = 1.0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    initializeAudio();
  }

  Future<void> initializeAudio() async {
    await player.setUrl(audioPlaylist.first.url);

    duration = player.duration ?? Duration.zero;

    player.positionStream.listen((positionData) {
      if (!mounted) return;

      setState(() {
        position = positionData;
      });
    });

    player.durationStream.listen((durationData) {
      if (!mounted || durationData == null) return;

      setState(() {
        duration = durationData;
      });
    });
  }

  Future<void> loadAudio(String url) async {
    await player.stop();

    await player.setUrl(url);

    await player.play();
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          const Icon(Icons.music_note, size: 100),

          const SizedBox(height: 20),

          Text(position.toString().split('.').first),

          Slider(
            value: position.inSeconds.toDouble(),

            max: duration.inSeconds.toDouble() == 0
                ? 1
                : duration.inSeconds.toDouble(),

            onChanged: (value) {
              player.seek(Duration(seconds: value.toInt()));
            },
          ),

          Text(duration.toString().split('.').first),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              IconButton(
                icon: const Icon(Icons.play_arrow),

                onPressed: () {
                  player.play();
                },
              ),

              IconButton(
                icon: const Icon(Icons.pause),

                onPressed: () {
                  player.pause();
                },
              ),

              IconButton(
                icon: const Icon(Icons.stop),

                onPressed: () {
                  player.stop();
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          DropdownButton<double>(
            value: speed,

            items: const [
              DropdownMenuItem(value: 1, child: Text('1x')),

              DropdownMenuItem(value: 1.5, child: Text('1.5x')),

              DropdownMenuItem(value: 2, child: Text('2x')),
            ],

            onChanged: (value) {
              if (value == null) return;

              setState(() {
                speed = value;
              });

              player.setSpeed(value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: audioPlaylist.length,

              itemBuilder: (context, index) {
                final item = audioPlaylist[index];

                return ListTile(
                  selected: selectedIndex == index,

                  title: Text(item.title),

                  leading: const Icon(Icons.music_note),

                  onTap: () async {
                    setState(() {
                      selectedIndex = index;
                    });

                    await loadAudio(item.url);
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
