import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:task_manager/services/task_data_base.dart';

// Page
import 'package:task_manager/pages/home_page.dart';

void main() async {

   //await TaskDataBase.initialize();
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskDataBase(),
      child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget
{
   @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      home: HomePage(),
    );
  }
}