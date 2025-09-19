import 'package:flutter/material.dart';
import 'package:task_manager/widgets/task_card.dart';
//Data
import 'package:task_manager/models/TestData.dart';
//Enum
import 'package:task_manager/models/enums/TaskStatus.dart';
import 'package:task_manager/models/enums/TaskPriority.dart';


class BodyTask extends StatefulWidget {
  const BodyTask({super.key});

  @override
  State<BodyTask> createState() => _BodyTaskState();
}

class _BodyTaskState extends State<BodyTask> {
  final List<Testdata> _testData = [
    Testdata(name: 'Test 1', id: 1, status: TaskStatus.archived, priority: Taskpriority.average, dateTime: DateTime(2025,12,10), description: 'lhfdsdljkfhdslkjhfdslkjhfsdkjhfdskjfhsdkjfh'),
    Testdata(name: 'Test 2', id: 2, status: TaskStatus.completed, priority: Taskpriority.high, dateTime: DateTime(1099,5,27), description: 'dsfsdfklsdhflkjsd'),
    Testdata(name: 'Test 3', id: 3, status: TaskStatus.inProgress, priority: Taskpriority.high, dateTime: DateTime(4545,8,15), description: 'dsfkjsdflkjhdskljfhsdoljkfhsdlkfjhsdkjfhdskjfhsdkjfhkjsdhfkjsdfhsd'),
    Testdata(name: 'Test 4', id: 4, status: TaskStatus.inProgress, priority: Taskpriority.high, dateTime: DateTime(2022,9,20), description: 'skdjhfksjdhfkjsdhfdkjsdhf'),
    Testdata(name: 'Test 5', id: 5, status: TaskStatus.inProgress, priority: Taskpriority.short, dateTime: DateTime(2014,7,8), description: 'dsfkjjsdhgfkjsdhfkj'),
    Testdata(name: 'Test 6', id: 6, status: TaskStatus.pending, priority: Taskpriority.short, dateTime: DateTime(2018,12,31),description: 'sdf'),
    Testdata(name: 'Test 7', id: 7, status: TaskStatus.pending, priority: Taskpriority.average,dateTime: DateTime(2002,4,12), description: 'sdkljfsdlkjflksdjflksdjflsdkjflskdjflskdjfsldk'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 25,),

          // Title
          Center(
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Expanded(flex:1, child: Icon(Icons.task_outlined,size: 40,color: Colors.white,)),
                  Expanded(flex: 2 , child: Text('My Task',style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ),

          Divider(height: 25,color: Colors.white,thickness: 1, indent: 65, endIndent: 65,),

          Center(
            child: SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width *0.95,
              child: Align(
                alignment: AlignmentGeometry.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        const SizedBox(height: 10),

                        ..._testData.map((test)=>CardItemProject(testdata: test)).toList(),

                    ],
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ));
  }
}