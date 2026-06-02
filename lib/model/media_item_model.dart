class MediaItemModel {
  final String title;
  final String url;

  const MediaItemModel({required this.title, required this.url});
}

final audioPlaylist = [
  MediaItemModel(
    title: 'SoundHelix Song 1',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  ),

  MediaItemModel(
    title: 'SoundHelix Song 2',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
  ),

  MediaItemModel(
    title: 'SoundHelix Song 3',
    url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  ),
];

final videoPlaylist = [
  MediaItemModel(
    title: 'Bee Video',
    url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ),

  MediaItemModel(
    title: 'Big Buck Bunny',
    url:
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ),

  MediaItemModel(
    title: 'Elephant Dream',
    url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ),
];
