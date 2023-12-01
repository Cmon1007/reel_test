import 'package:flutter/material.dart';
import 'package:shorts_video_player/screen/video_play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _selectedScreen = [
    VideoPlayScreen(),
    Text("Seacrh"),
    Text("Add"),
    Text("Profile"),
    Text("Settings"),
  ];
  String _appBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return "Home";
      case 1:
        return "Search";
      case 2:
        return "Profile";
      case 3:
        return "Settings";
      case 4:
        return "Add";
      default:
        return "Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(_appBarTitle()),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.white,
        onTap: _onTapped,
        iconSize: 30,
        elevation: 5,
      ),
      body: _selectedScreen.elementAt(_selectedIndex),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
