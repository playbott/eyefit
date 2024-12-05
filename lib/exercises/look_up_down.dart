import 'package:flutter/material.dart';

class LookUpDown extends StatefulWidget {
  @override
  _LookUpDownState createState() => _LookUpDownState();
}

class _LookUpDownState extends State<LookUpDown>
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

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = (constraints.maxHeight*0.95) / 2;

          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value * maxHeight),
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
