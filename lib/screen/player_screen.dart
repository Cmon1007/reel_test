import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final VideoPlayerController videoController;
  const PlayerScreen({required this.videoController, Key? key})
      : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late ChewieController _chewieControllers;
  bool _isVideoLoading = true;

  @override
  void initState() {
    _chewieControllers = ChewieController(
        aspectRatio: 16 / 16,
        videoPlayerController: widget.videoController,
        autoPlay: true,
        looping: true,
        allowFullScreen: false,
        showOptions: false,
        showControlsOnInitialize: false);
    widget.videoController.addListener(videControllerListener);

    super.initState();
  }

  @override
  void dispose() {
    widget.videoController.removeListener(videControllerListener);
    _chewieControllers.dispose();
    super.dispose();
  }

  void videControllerListener() {
    if (widget.videoController.value.isInitialized) {
      if (mounted) {
        setState(() {
          _isVideoLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isVideoLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          : Chewie(controller: _chewieControllers),
    );
  }
}
