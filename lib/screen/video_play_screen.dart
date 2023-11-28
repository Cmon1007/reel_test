import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shorts_video_player/domain/model/new_model.dart';
import 'package:shorts_video_player/screen/player_screen.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({super.key});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  List<Movie> movies = [];

  Future<void> _loadMovies() async {
    String jsonString = await rootBundle.loadString('assets/json/api.json');
    List<dynamic> movieList = json.decode(jsonString);

    setState(() {
      movies = List<Map<String, dynamic>>.from(movieList[0]['videos'])
          .map((json) => Movie.fromJson(json))
          .toList();
    });
  }

  @override
  void initState() {
    _loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return PlayerScreen(videoUrl: movie.sources[0]);
        },
      ),
    );
  }
}
