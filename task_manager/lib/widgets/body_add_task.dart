import 'package:flutter/material.dart';
import 'package:task_manager/widgets/ui_kit/input_custom.dart';
import 'package:task_manager/widgets/ui_kit/table_calendar_custom.dart';

class BodyAddTask extends StatefulWidget {
  const BodyAddTask({super.key});

  @override
  State<BodyAddTask> createState() => _BodyAddTaskState();
}

class _BodyAddTaskState extends State<BodyAddTask> {

  DateTime? _selectedDate;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();


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
                  Expanded(flex:1, child: Icon(Icons.add,size: 40,color: Colors.white,)),
                  Expanded(flex: 2 , child: Text('Add Task',style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
          ),

          Divider(height: 25,color: Colors.white,thickness: 1, indent: 65, endIndent: 65,),

          SizedBox(height: 25,),

          InputCustom(nameInput: 'Task Name', textEditingController: taskNameController,),

          SizedBox(height: 10,),

          InputCustom(nameInput: 'Description', textEditingController: taskDescriptionController,),

          //Календарь
          TableCalendarCustom(initialDateTime: _selectedDate, onDateChanged: (newDate){
            setState(() {
              _selectedDate = newDate;
            });
          },),

          

        ],
      )
    );
  }
}