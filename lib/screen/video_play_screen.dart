import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shorts_video_player/domain/model/new_model.dart';
import 'package:shorts_video_player/screen/player_screen.dart';
import 'package:shorts_video_player/widget/like_button_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({super.key});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  List<Movie> movies = [];
  List<VideoPlayerController> _videoControllers = [];
  PageController _pageController = PageController();
  Future<void> _loadMovies() async {
    String jsonString = await rootBundle.loadString('assets/json/api.json');
    List<dynamic> movieList = json.decode(jsonString);
    _videoControllers.forEach((controller) {
      controller.pause();
      controller.dispose();
    });
    setState(() {
      movies = List<Map<String, dynamic>>.from(movieList[0]['videos'])
          .map((json) => Movie.fromJson(json))
          .toList();
      _videoControllers = movies
          .map((movie) => VideoPlayerController.network(movie.sources[0]))
          .toList();
    });
    _videoControllers.forEach((controller) async {
      await controller.initialize();
      controller.setVolume(1.0);
    });
    if (_videoControllers.isNotEmpty) {
      _videoControllers[0].play();
    }
  }

  @override
  void initState() {
    _loadMovies();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  void dispose() {
    _videoControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final videoController = _videoControllers[index];
          return Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                AspectRatio(
                    aspectRatio: 14 / 16,
                    child: PlayerScreen(videoController: videoController)),
                SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              movie.thumb,
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${movie.title}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                bottom: 0,
                top: 320,
                right: 0,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            LikeButtonWidet(isLiked: false),
                            Text(
                              "Likes",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.comment,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              "Comment",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/share.png",
                              height: 30,
                              color: Colors.white,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ]);
        },
      ),
    );
  }
}
