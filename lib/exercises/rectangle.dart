import 'package:flutter/material.dart';

class Rectangle extends StatefulWidget {
  const Rectangle(
      {super.key});

  @override
  RectangleState createState() => RectangleState();
}

class RectangleState extends State<Rectangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final radius = constraints.maxWidth * 0.05;
          final width = constraints.maxWidth - radius * 2;
          final height = constraints.maxHeight - radius * 2;
          final perimeter = 2 * (width + height);

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = _controller.value * perimeter;
              double dx = 0.0, dy = 0.0;

              if (progress <= width) {
                dx = progress;
                dy = 0.0;
              } else if (progress <= width + height) {
                dx = width;
                dy = progress - width;
              } else if (progress <= 2 * width + height) {
                dx = 2 * width + height - progress;
                dy = height;
              } else {
                dx = 0.0;
                dy = perimeter - progress;
              }

              return Transform.translate(
                offset: Offset(dx, dy),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.blueAccent,
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
