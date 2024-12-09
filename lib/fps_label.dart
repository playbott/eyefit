import 'dart:async';
import 'package:flutter/material.dart';

class FpsLabel extends StatefulWidget {
  const FpsLabel({super.key, required this.child});

  final Widget child;

  @override
  FpsLabelState createState() => FpsLabelState();
}

class FpsLabelState extends State<FpsLabel> {
  int _frameCount = 0;
  int _lastTimeStamp = 0;
  final StreamController<double> _fpsStreamController = StreamController();

  Offset _position = const Offset(10, 100);

  @override
  void dispose() {
    super.dispose();
    _fpsStreamController.close();
  }

  @override
  void initState() {
    super.initState();
    _frameCount = 0;
    _lastTimeStamp = DateTime.now().millisecondsSinceEpoch;

    Future.delayed(const Duration(milliseconds: 100), () => _calculateFps());
  }

  void _calculateFps() {
    if (mounted) {
      final currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
      _frameCount++;

      if (currentTimeStamp - _lastTimeStamp >= 300) {
        final fps = (_frameCount / (currentTimeStamp - _lastTimeStamp)) * 1000;
        _fpsStreamController.add(fps);
        _lastTimeStamp = currentTimeStamp;
        _frameCount = 0;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) => _calculateFps());
    } else {
      _fpsStreamController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const widgetSize = Size(100, 50);

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        widget.child,
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                double newX = _position.dx + details.delta.dx;
                double newY = _position.dy + details.delta.dy;

                newX = newX.clamp(0, screenSize.width - widgetSize.width);
                newY = newY.clamp(0, screenSize.height - widgetSize.height);

                _position = Offset(newX, newY);
              });
            },
            child: Container(
              width: widgetSize.width,
              height: widgetSize.height,
              color: Colors.black54,
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
                child: DefaultTextStyle(
                  style: ThemeData.light()
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                  child: StreamBuilder<double>(
                      stream: _fpsStreamController.stream,
                      builder: (context, snapshot) {
                        final value = snapshot.data ?? 0.0;
                        return Text(
                          'FPS: ${value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
