import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo, 
      ),
      body: Container(
        color: Colors.blue[100], 
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedCard('assets/lottie/Lottie2.json'),
                AnimatedCard('assets/lottie/Lottie4.json'),
                AnimatedCard('assets/lottie/Lottie3.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedCard extends StatefulWidget {
  final String animationPath;

  AnimatedCard(this.animationPath);

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

 @override
void initState() {
  super.initState();
  _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isAnimating) {
          _controller.stop();
        } else {
          _controller.repeat(); 
        }
      },
      child: Card(
        elevation: 4.0,
        child: Lottie.asset(widget.animationPath, controller: _controller, width: 200, height: 200),
      ),
    );
  }
}