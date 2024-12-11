import 'package:flutter/material.dart';
import 'dart:math';

class FigureEightAnimation extends StatefulWidget {
  const FigureEightAnimation({super.key});

  @override
  FigureEightAnimationState createState() => FigureEightAnimationState();
}

class FigureEightAnimationState extends State<FigureEightAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: FigureEightPainter(_animation.value),
            size: MediaQuery.of(context).size,
          );
        },
      ),
    );
  }
}

class FigureEightPainter extends CustomPainter {
  final double progress;

  FigureEightPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.height / 2.2;

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(-pi / 2);
    canvas.translate(-centerX, -centerY);
    canvas.restore();

    final t = progress % (2 * pi);
    final x = centerX + radius * cos(t);
    final y = centerY + radius * sin(2 * t) / 2;

    final rotatedX = centerX + (y - centerY);
    final rotatedY = centerY - (x - centerX);

    final currentPoint = Offset(rotatedX, rotatedY);

    final dotPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(currentPoint, 15.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
