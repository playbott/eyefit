import 'package:flutter/material.dart';
import 'entities/exercise.dart';
import 'exercises/diagonals.dart';
import 'exercises/draw_circle.dart';
import 'exercises/look_up_down.dart';
import 'exercises/pendulum.dart';
import 'exercise_screen.dart';
import 'exercises/rectangle.dart';
import 'fps_label.dart';

final exercises = [
  Exercise(
    title: 'Взгляд вверх и вниз',
    description: 'Следите за движением вверх и вниз.',
    widget: LookUpDown(),
  ),
  const Exercise(
    title: 'Ходики',
    description: 'Маятниковое движение влево-вправо.',
    widget: Pendulum(),
  ),
  const Exercise(
    title: 'Чертим круг',
    description: 'Следите за движением по кругу.',
    widget: DrawCircle(),
  ),
  Exercise(
    title: 'Диагонали',
    description: 'Следите за движением по диагоналям.',
    widget: Diagonals(),
  ),
  const Exercise(
    title: 'Рисуем прямоугольник',
    description: 'Следите за движением по периметру прямоугольника.',
    widget: Rectangle(),
  ),
];

class ExerciseMenu extends StatelessWidget {
  const ExerciseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Упражнения для глаз'),
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(exercise.title),
                  subtitle: Text(exercise.description),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FpsLabel(
                          child: ExerciseScreen(
                              content: exercise.widget,
                              title: exercise.title),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
