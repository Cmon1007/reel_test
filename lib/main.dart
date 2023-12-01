import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shorts_video_player/screen/home_screen.dart';
import 'package:shorts_video_player/screen/video_play_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
