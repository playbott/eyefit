import 'package:flutter/material.dart';
import 'dart:math';

class DrawCircle extends StatefulWidget {
  const DrawCircle({super.key});

  @override
  DrawCircleState createState() => DrawCircleState();
}

class DrawCircleState extends State<DrawCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isReversed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isReversed = !_isReversed;
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isReversed = !_isReversed;
        _controller.forward();
      }
    });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final radius = min(constraints.maxWidth, constraints.maxHeight) / 2.5;

          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final angle = 2 * pi * _animation.value;
              final dx = radius * cos(angle);
              final dy = radius * sin(angle);

              return Transform.rotate(
                angle: pi / 2,
                child: Transform.translate(
                  offset: Offset(dx, dy),
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
