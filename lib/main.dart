import 'package:flutter/material.dart';
import 'exercise_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EyeFit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExerciseMenu(), // Подключаем меню упражнений.
    );
  }
}
