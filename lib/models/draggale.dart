import 'package:flutter/material.dart';

class FruitItem {
  final int id;
  final String name;
  final Color color;
  bool isCorrect;
  final String image;

  FruitItem({required this.name, required this.id, required this.image, required this.color, this.isCorrect = false});
}

class FruitImage {
  final String name;
  final String image;
  bool isCorrect;
  final Color color;

  FruitImage({required this.name, required this.image, required this.color, this.isCorrect = false});
}
