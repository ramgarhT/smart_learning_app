// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

// class ProfessionalAudioPlayer extends StatefulWidget {
//   const ProfessionalAudioPlayer({super.key});

//   @override
//   State<ProfessionalAudioPlayer> createState() => _ProfessionalAudioPlayerState();
// }

// class _ProfessionalAudioPlayerState extends State<ProfessionalAudioPlayer> {
//   late VideoPlayerController _controller;
//   late ChewieController _chewieController;
//   bool isMuted = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAudio();
//   }

//   void _initializeAudio() async {
//     _controller = VideoPlayerController.networkUrl(
//       Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
//     );

//     await _controller.initialize();

//     _chewieController = ChewieController(
//       videoPlayerController: _controller,
//       autoPlay: false,
//       looping: true,
//       allowMuting: true,
//       showControls: false, // We create custom controls
//     );

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Title and Artist
//           Text(
//             "SoundHelix Song 1",
//             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "Artist: SoundHelix",
//             style: TextStyle(color: Colors.grey, fontSize: 14),
//           ),

//           SizedBox(height: 12),

//           // Audio Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Backward Button
//               IconButton(
//                 icon: Icon(Icons.fast_rewind, color: Colors.white, size: 30),
//                 onPressed: () {
//                   _controller.seekTo(_controller.value.position - Duration(seconds: 10));
//                 },
//               ),

//               // Play / Pause Button
//               IconButton(
//                 icon: Icon(
//                   _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
//                   color: Colors.white,
//                   size: 50,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _controller.value.isPlaying ? _controller.pause() : _controller.play();
//                   });
//                 },
//               ),

//               // Forward Button
//               IconButton(
//                 icon: Icon(Icons.fast_forward, color: Colors.white, size: 30),
//                 onPressed: () {
//                   _controller.seekTo(_controller.value.position + Duration(seconds: 10));
//                 },
//               ),
//             ],
//           ),

//           // Seekbar
//           Slider(
//             activeColor: Colors.blueAccent,
//             inactiveColor: Colors.grey,
//             min: 0,
//             max: _controller.value.duration.inSeconds.toDouble(),
//             value: _controller.value.position.inSeconds.toDouble(),
//             onChanged: (value) {
//               _controller.seekTo(Duration(seconds: value.toInt()));
//             },
//           ),

//           // Time display
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 _formatDuration(_controller.value.position),
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//               Text(
//                 _formatDuration(_controller.value.duration),
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ],
//           ),

//           // Additional Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Mute Button
//               IconButton(
//                 icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
//                 onPressed: () {
//                   setState(() {
//                     isMuted = !isMuted;
//                     _controller.setVolume(isMuted ? 0 : 1);
//                   });
//                 },
//               ),

//               // Loop Button
//               IconButton(
//                 icon: Icon(Icons.loop, color: Colors.white),
//                 onPressed: () {
//                   _chewieController.setLooping(!_chewieController.isLooping);
//                   setState(() {});
//                 },
//               ),

//               // Speed Control
//               DropdownButton<double>(
//                 dropdownColor: Colors.black,
//                 value: _chewieController.playbackSpeeds,
//                 icon: Icon(Icons.speed, color: Colors.white),
//                 items: [0.5, 1.0, 1.5, 2.0]
//                     .map((speed) => DropdownMenuItem(
//                           child: Text("${speed}x", style: TextStyle(color: Colors.white)),
//                           value: speed,
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _chewieController.setPlaybackSpeed(value!);
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
// }
