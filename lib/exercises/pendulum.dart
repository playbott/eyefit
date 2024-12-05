import 'package:flutter/material.dart';

class Pendulum extends StatefulWidget {
  const Pendulum({super.key});

  @override
  _PendulumState createState() => _PendulumState();
}

class _PendulumState extends State<Pendulum>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        const ballDiameter = 50.0;
        final maxOffset = screenWidth - ballDiameter;
        return Container(
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value * maxOffset, 0),
                child: Container(
                  width: ballDiameter,
                  height: ballDiameter,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}