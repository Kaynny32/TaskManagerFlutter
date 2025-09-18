import 'package:flutter/material.dart';

class Colorgradient 
{
  final String name;
  final LinearGradient gradient;
  final List<Color> colors;

  Colorgradient({
    required this.name,
    required this.colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    }): gradient = LinearGradient(
    colors: colors,
    begin: begin,
    end: end,
  );

  // Предопределенные градиенты
  static final List<Colorgradient> predefinedGradients = [
    Colorgradient(
      name: 'Ocean Blue',
      colors: [Colors.blue.shade300, Colors.blue.shade900],
    ),
    Colorgradient(
      name: 'Sunset',
      colors: [Colors.red, Colors.orange, Colors.yellow],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    Colorgradient(
      name: 'Forest',
      colors: [Colors.green.shade400, Colors.green.shade800],
    ),
    Colorgradient(
      name: 'Purple Dream',
      colors: [Colors.purple, Colors.pink],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    Colorgradient(
      name: 'Sunrise',
      colors: [Colors.pink.shade200, Colors.orange.shade300],
    ),
    Colorgradient(
      name: 'SmoothMulticolor',
      colors: [Color(0xFF0b8793), Color(0xFF204d69),Color(0xFF2c1a47),Color(0xFF2c1a47)],
    ),
  ];

  // Метод для получения градиента по индексу
  static LinearGradient getByIndex(int index) {
    return predefinedGradients[index % predefinedGradients.length].gradient;
  }

  // Метод для получения всех градиентов
  static List<LinearGradient> getAllGradients() {
    return predefinedGradients.map((g) => g.gradient).toList();
  }

  // Метод для получения градиента по имени
  static LinearGradient? getByName(String name) {
    try {
      return predefinedGradients
          .firstWhere((g) => g.name == name)
          .gradient;
    } catch (e) {
      return null;
    }
  }
}