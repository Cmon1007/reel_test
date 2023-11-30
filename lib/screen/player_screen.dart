import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String videoUrl;
  const PlayerScreen({required this.videoUrl, Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController _controllers;
  late ChewieController _chewieControllers;

  @override
  void initState() {
    _controllers = VideoPlayerController.network(widget.videoUrl);
    _chewieControllers = ChewieController(
      aspectRatio: 16 / 16,
      videoPlayerController: _controllers,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    _chewieControllers.dispose();
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chewie(controller: _chewieControllers),
    );
  }
}
