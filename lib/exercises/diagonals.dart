import 'package:flutter/material.dart';

class Diagonals extends StatefulWidget {
  @override
  _DiagonalsState createState() => _DiagonalsState();
}

class _DiagonalsState extends State<Diagonals>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth - 40;
          final maxHeight = constraints.maxHeight - 40;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = _controller.value;

              double dx = 0, dy = 0;

              curvedProgress(double value) => Curves.easeInOut.transform(value);

              if (progress <= 0.25) {
                final localProgress = curvedProgress(progress / 0.25);
                dx = localProgress * maxWidth;
                dy = localProgress * maxHeight;
              } else if (progress <= 0.5) {
                final localProgress = curvedProgress((progress - 0.25) / 0.25);
                dx = (1 - localProgress) * maxWidth;
                dy = (1 - localProgress) * maxHeight;
              } else if (progress <= 0.75) {
                final localProgress = curvedProgress((progress - 0.5) / 0.25);
                dx = (1 - localProgress) * maxWidth;
                dy = localProgress * maxHeight;
              } else {
                final localProgress = curvedProgress((progress - 0.75) / 0.25);
                dx = localProgress * maxWidth;
                dy = (1 - localProgress) * maxHeight;
              }

              return Transform.translate(
                offset: Offset(dx, dy),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
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
