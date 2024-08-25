import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'WavePainter.dart';

class WaveAnimationBackground extends StatefulWidget {
  @override
  _WaveAnimationBackgroundState createState() => _WaveAnimationBackgroundState();
}

class _WaveAnimationBackgroundState extends State<WaveAnimationBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WavePainter(
        waveHeight: 70.0,
        waveLength: 600.0,
        phase: _animation.value,
      ),
      child: Container(),
    );
  }
}