import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Generate/generated/locale_keys.g.dart';
import 'package:flutter_school/Presentation/Screen/Animation_Screen.dart';
import 'package:flutter_school/Presentation/Screen/News_Screen.dart';
import 'package:flutter_school/Presentation/Screen/Profile_Screen.dart';
import 'package:flutter_school/Presentation/Screen/Qr_Screen.dart';
import 'package:flutter_school/Presentation/Screen/Stories_Screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;

  final List<Widget> _pages = [
    UserPage(),
    Stories(),
    QRScreen(),
    NewsScreen(),
    Animated(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text(LocaleKeys.Profile.tr()),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.add_a_photo),
            title: Text(LocaleKeys.stories.tr()),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.qr_code),
            title: Text('Qr'),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.photo),
            title: Text(LocaleKeys.News.tr()),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.video_camera_back),
            title: Text(LocaleKeys.Animation.tr()),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}


