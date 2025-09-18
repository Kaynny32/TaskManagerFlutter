import 'package:flutter/material.dart';

import 'package:task_manager/widgets/task_card.dart';

import 'package:task_manager/models/TestData.dart';

class BodyTask extends StatefulWidget {
  const BodyTask({super.key});

  @override
  State<BodyTask> createState() => _BodyTaskState();
}

class _BodyTaskState extends State<BodyTask> {
  final List<Testdata> _testData = [
    Testdata(name: 'Test 1', id: 1),
    Testdata(name: 'Test 2', id: 2),
    Testdata(name: 'Test 3', id: 3),
    Testdata(name: 'Test 4', id: 4),
    Testdata(name: 'Test 5', id: 5),
    Testdata(name: 'Test 6', id: 6),
    Testdata(name: 'Test 7', id: 7),
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