import 'package:flutter/material.dart';

class Exercise {
  final String title;
  final String description;
  final Widget widget;

  const Exercise({
    required this.title,
    required this.description,
    required this.widget,
  });
}