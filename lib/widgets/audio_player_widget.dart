// import 'package:flutter/material.dart';
// import 'package:flutter_poc/widgets/audio_visualizer.dart';
// import 'package:just_audio/just_audio.dart';
// import '../services/audio_player_service.dart';

// class AudioPlayerWidget extends StatefulWidget {
//   const AudioPlayerWidget({super.key});

//   @override
//   State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
// }

// class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
//     with SingleTickerProviderStateMixin {
//   final AudioPlayerService _audioService = AudioPlayerService();
//   late AnimationController _albumArtController;
//   final TextEditingController _urlController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _audioService.init();

//     _albumArtController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 12),
//     );

//     // Listen to play state to spin the album art
//     _audioService.playerStateStream.listen((state) {
//       if (state.playing) {
//         _albumArtController.repeat();
//       } else {
//         _albumArtController.stop();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _albumArtController.dispose();
//     _urlController.dispose();
//     super.dispose();
//   }

//   String _formatDuration(Duration d) {
//     if (d == Duration.zero) return "00:00";
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(d.inMinutes.remainder(60));
//     final seconds = twoDigits(d.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Glassmorphic Premium Player Container
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1E2230) : Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               border: Border.all(
//                 color: isDark ? const Color(0xFF2E334D) : Colors.grey.shade200,
//                 width: 1.5,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: (isDark ? Colors.black87 : Colors.grey.shade300)
//                       .withOpacity(0.3),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 // Album art and visualizer
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Outer glowing visualizer ring
//                     SizedBox(
//                       height: 200,
//                       width: 200,
//                       child: StreamBuilder<PlayerState>(
//                         stream: _audioService.playerStateStream,
//                         builder: (context, snapshot) {
//                           final playing = snapshot.data?.playing ?? false;
//                           return AudioVisualizer(
//                             isPlaying: playing,
//                             speed: _audioService.player.speed,
//                           );
//                         },
//                       ),
//                     ),
//                     // Rotating Album Cover
//                     RotationTransition(
//                       turns: _albumArtController,
//                       child: Container(
//                         height: 140,
//                         width: 140,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color(0xFF00F2FE).withOpacity(0.4),
//                               blurRadius: 15,
//                               spreadRadius: 2,
//                             ),
//                           ],
//                         ),
//                         child: ClipOval(
//                           child: Image.network(
//                             _audioService.currentTrack.coverUrl,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 Container(
//                                   color: Colors.grey.shade800,
//                                   child: const Icon(
//                                     Icons.music_note,
//                                     size: 50,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),

//                 // Title & Artist
//                 Text(
//                   _audioService.currentTrack.title,
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   '${_audioService.currentTrack.artist}  •  ${_audioService.currentTrack.album}',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 24),

//                 // Seek Progress Slider with dual Buffering visual feedback
//                 StreamBuilder<Duration>(
//                   stream: _audioService.positionStream,
//                   builder: (context, snapshotPosition) {
//                     final position = snapshotPosition.data ?? Duration.zero;
//                     return StreamBuilder<Duration?>(
//                       stream: _audioService.durationStream,
//                       builder: (context, snapshotDuration) {
//                         final duration = snapshotDuration.data ?? Duration.zero;
//                         return StreamBuilder<Duration>(
//                           stream: _audioService.bufferedPositionStream,
//                           builder: (context, snapshotBuffered) {
//                             final buffered =
//                                 snapshotBuffered.data ?? Duration.zero;

//                             double maxSec = duration.inMilliseconds.toDouble();
//                             double posSec = position.inMilliseconds.toDouble();
//                             double bufSec = buffered.inMilliseconds.toDouble();

//                             if (maxSec <= 0) maxSec = 1;
//                             if (posSec > maxSec) posSec = maxSec;
//                             if (bufSec > maxSec) bufSec = maxSec;

//                             return Column(
//                               children: [
//                                 // Layered custom slider with secondary buffer track
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     // Custom Buffer Progress Bar
//                                     Container(
//                                       height: 4,
//                                       width: double.infinity,
//                                       margin: const EdgeInsets.symmetric(
//                                         horizontal: 20,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: isDark
//                                             ? Colors.grey.shade800
//                                             : Colors.grey.shade300,
//                                         borderRadius: BorderRadius.circular(2),
//                                       ),
//                                       alignment: Alignment.centerLeft,
//                                       child: FractionallySizedBox(
//                                         widthFactor: bufSec / maxSec,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: const Color(
//                                               0xFF00F2FE,
//                                             ).withOpacity(0.35),
//                                             borderRadius: BorderRadius.circular(
//                                               2,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     // Actual Seek Slider
//                                     SliderTheme(
//                                       data: SliderTheme.of(context).copyWith(
//                                         activeTrackColor: const Color(
//                                           0xFF00F2FE,
//                                         ),
//                                         inactiveTrackColor: Colors
//                                             .transparent, // Let buffer show
//                                         thumbColor: const Color(0xFF00F2FE),
//                                         thumbShape: const RoundSliderThumbShape(
//                                           enabledThumbRadius: 7,
//                                         ),
//                                         overlayColor: const Color(
//                                           0xFF00F2FE,
//                                         ).withOpacity(0.2),
//                                         trackHeight: 4,
//                                       ),
//                                       child: Slider(
//                                         min: 0,
//                                         max: maxSec,
//                                         value: posSec,
//                                         onChanged: (val) {
//                                           _audioService.seek(
//                                             Duration(milliseconds: val.toInt()),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         _formatDuration(position),
//                                         style: theme.textTheme.bodySmall
//                                             ?.copyWith(
//                                               color: isDark
//                                                   ? Colors.grey.shade400
//                                                   : Colors.grey.shade600,
//                                             ),
//                                       ),
//                                       if (duration == Duration.zero)
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 2,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.red.shade900,
//                                             borderRadius: BorderRadius.circular(
//                                               6,
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             "LIVE STREAM",
//                                             style: TextStyle(
//                                               fontSize: 9,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         )
//                                       else
//                                         Text(
//                                           _formatDuration(duration),
//                                           style: theme.textTheme.bodySmall
//                                               ?.copyWith(
//                                                 color: isDark
//                                                     ? Colors.grey.shade400
//                                                     : Colors.grey.shade600,
//                                               ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Music Player Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Shuffle
//                     IconButton(
//                       icon: Icon(
//                         _audioService.isShuffleEnabled
//                             ? Icons.shuffle_on_rounded
//                             : Icons.shuffle_rounded,
//                         color: _audioService.isShuffleEnabled
//                             ? const Color(0xFF00F2FE)
//                             : (isDark ? Colors.grey : Colors.grey.shade600),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _audioService.toggleShuffle();
//                         });
//                       },
//                     ),
//                     // Previous
//                     IconButton(
//                       icon: const Icon(Icons.skip_previous_rounded, size: 36),
//                       color: isDark ? Colors.white : Colors.black87,
//                       onPressed: () {
//                         setState(() {
//                           _audioService.previous();
//                         });
//                       },
//                     ),
//                     // Play / Pause StreamBuilder
//                     StreamBuilder<PlayerState>(
//                       stream: _audioService.playerStateStream,
//                       builder: (context, snapshot) {
//                         final state = snapshot.data;
//                         final processingState = state?.processingState;
//                         final playing = state?.playing ?? false;

//                         if (processingState == ProcessingState.buffering) {
//                           return Container(
//                             height: 64,
//                             width: 64,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFF00F2FE),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Padding(
//                               padding: EdgeInsets.all(16.0),
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 3,
//                               ),
//                             ),
//                           );
//                         }

//                         return InkWell(
//                           onTap: () {
//                             if (playing) {
//                               _audioService.pause();
//                             } else {
//                               _audioService.play();
//                             }
//                           },
//                           borderRadius: BorderRadius.circular(32),
//                           child: Container(
//                             height: 64,
//                             width: 64,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF00F2FE),
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: const Color(
//                                     0xFF00F2FE,
//                                   ).withOpacity(0.3),
//                                   blurRadius: 10,
//                                   spreadRadius: 2,
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               playing
//                                   ? Icons.pause_rounded
//                                   : Icons.play_arrow_rounded,
//                               size: 40,
//                               color: Colors.white,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     // Next
//                     IconButton(
//                       icon: const Icon(Icons.skip_next_rounded, size: 36),
//                       color: isDark ? Colors.white : Colors.black87,
//                       onPressed: () {
//                         setState(() {
//                           _audioService.next();
//                         });
//                       },
//                     ),
//                     // Repeat LoopMode
//                     IconButton(
//                       icon: Icon(
//                         _audioService.loopMode == LoopMode.one
//                             ? Icons.repeat_one_rounded
//                             : _audioService.loopMode == LoopMode.all
//                             ? Icons.repeat_on_rounded
//                             : Icons.repeat_rounded,
//                         color: _audioService.loopMode != LoopMode.off
//                             ? const Color(0xFF00F2FE)
//                             : (isDark ? Colors.grey : Colors.grey.shade600),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _audioService.toggleLoopMode();
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),

//                 // Volume & Speed Slider panel
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.volume_down_rounded,
//                       color: isDark ? Colors.grey : Colors.grey.shade600,
//                       size: 20,
//                     ),
//                     Expanded(
//                       child: SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           activeTrackColor: const Color(0xFF4FACFE),
//                           thumbColor: const Color(0xFF4FACFE),
//                           thumbShape: const RoundSliderThumbShape(
//                             enabledThumbRadius: 6,
//                           ),
//                           trackHeight: 3,
//                         ),
//                         child: Slider(
//                           value: _audioService.player.volume,
//                           onChanged: (val) {
//                             setState(() {
//                               _audioService.setVolume(val);
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     Icon(
//                       Icons.volume_up_rounded,
//                       color: isDark ? Colors.grey : Colors.grey.shade600,
//                       size: 20,
//                     ),
//                     const SizedBox(width: 20),
//                     // Speed selector
//                     DropdownButton<double>(
//                       value: _audioService.player.speed,
//                       dropdownColor: isDark
//                           ? const Color(0xFF1E2230)
//                           : Colors.white,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: isDark ? Colors.white : Colors.black87,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       underline: const SizedBox(),
//                       icon: const Icon(Icons.speed_rounded, size: 16),
//                       items: const [
//                         DropdownMenuItem(value: 0.5, child: Text("0.5x ")),
//                         DropdownMenuItem(value: 1.0, child: Text("1.0x ")),
//                         DropdownMenuItem(value: 1.5, child: Text("1.5x ")),
//                         DropdownMenuItem(value: 2.0, child: Text("2.0x ")),
//                       ],
//                       onChanged: (double? newSpeed) {
//                         if (newSpeed != null) {
//                           setState(() {
//                             _audioService.setSpeed(newSpeed);
//                           });
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Custom Stream URL input panel
//           Container(
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1E2230) : Colors.white,
//               borderRadius: BorderRadius.circular(18),
//               border: Border.all(
//                 color: isDark ? const Color(0xFF2E334D) : Colors.grey.shade200,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   "Integrate Custom Audio Stream",
//                   style: theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _urlController,
//                         style: const TextStyle(fontSize: 13),
//                         decoration: InputDecoration(
//                           hintText: "Enter direct mp3 or radio stream URL...",
//                           isDense: true,
//                           filled: true,
//                           fillColor: isDark
//                               ? const Color(0xFF131622)
//                               : Colors.grey.shade100,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF00F2FE),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         final url = _urlController.text.trim();
//                         if (url.isNotEmpty) {
//                           _audioService
//                               .loadCustomUrl(url)
//                               .then((_) {
//                                 setState(() {
//                                   _audioService.play();
//                                 });
//                               })
//                               .catchError((err) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       "Failed to load stream: $err",
//                                     ),
//                                     backgroundColor: Colors.red.shade900,
//                                   ),
//                                 );
//                               });
//                         }
//                       },
//                       child: const Text(
//                         "Load Stream",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Playlist Select Panel
//           Container(
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1E2230) : Colors.white,
//               borderRadius: BorderRadius.circular(18),
//               border: Border.all(
//                 color: isDark ? const Color(0xFF2E334D) : Colors.grey.shade200,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   "Interactive Playlist",
//                   style: theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: _audioService.playlist.length,
//                   separatorBuilder: (context, index) =>
//                       const Divider(height: 1, color: Color(0xFF2E334D)),
//                   itemBuilder: (context, index) {
//                     final track = _audioService.playlist[index];
//                     final isCurrent = _audioService.currentIndex == index;

//                     return ListTile(
//                       dense: true,
//                       contentPadding: EdgeInsets.zero,
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(6),
//                         child: Image.network(
//                           track.coverUrl,
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Container(
//                                 color: Colors.grey.shade800,
//                                 width: 40,
//                                 height: 40,
//                                 child: const Icon(Icons.music_note, size: 20),
//                               ),
//                         ),
//                       ),
//                       title: Text(
//                         track.title,
//                         style: TextStyle(
//                           fontWeight: isCurrent
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                           color: isCurrent
//                               ? const Color(0xFF00F2FE)
//                               : (isDark ? Colors.white : Colors.black87),
//                         ),
//                       ),
//                       subtitle: Text(
//                         track.artist,
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: isCurrent
//                               ? const Color(0xFF00F2FE).withOpacity(0.8)
//                               : Colors.grey,
//                         ),
//                       ),
//                       trailing: isCurrent
//                           ? const Icon(
//                               Icons.graphic_eq_rounded,
//                               color: Color(0xFF00F2FE),
//                               size: 16,
//                             )
//                           : const Icon(Icons.play_arrow_rounded, size: 16),
//                       onTap: () {
//                         setState(() {
//                           _audioService.loadTrack(index).then((_) {
//                             _audioService.play();
//                           });
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
