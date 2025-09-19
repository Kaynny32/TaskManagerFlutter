import 'package:flutter/material.dart';
import 'package:task_manager/models/ColorGradient.dart';
import 'package:task_manager/widgets/bottom_navigation_bar.dart';
//Body
import 'package:task_manager/widgets/body_settings.dart';
import 'package:task_manager/widgets/body_task.dart';
import 'package:task_manager/widgets/body_add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  late List<Widget> _pages;

  void _onTabChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    _pages = [
      BodyTask(),
      BodyAddTask(),
      BodySettings(),      
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          // Фон
          Container(
            decoration: BoxDecoration(
              gradient: Colorgradient.getByName('SmoothMulticolor'),
            ),
          ),

          // Основной контент
          _pages[_currentPageIndex],

          // Панель
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: ButtonNavigationBarCustom(currentIndex: _currentPageIndex,onTabChanged: _onTabChanged,),
          ),         
        ],
      ),
    );
  }
}