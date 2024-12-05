import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  final Widget content;
  final String title;
  final Color backgroundColor;

  const ExerciseScreen({
    super.key,
    required this.content,
    required this.title,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: backgroundColor,
        child: Center(
          child: content,
        ),
      ),
    );
  }
}