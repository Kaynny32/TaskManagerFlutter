import 'package:flutter/material.dart';
import 'package:task_manager/models/TaskData.dart';
import 'package:task_manager/widgets/ui_kit/input_custom.dart';
import 'package:task_manager/widgets/ui_kit/table_calendar_custom.dart';
import 'package:task_manager/widgets/ui_kit/dropdown_custom.dart';
import 'package:task_manager/services/task_data_base.dart';
import 'package:provider/provider.dart';

class BodyAddTask extends StatefulWidget {
  const BodyAddTask({super.key});

  @override
  State<BodyAddTask> createState() => _BodyAddTaskState();
}

class _BodyAddTaskState extends State<BodyAddTask> {
  bool isActiveButton = false;
  TaskPriority? selectedPriority;
  TaskStatus? selectedStatus;
  DateTime? _selectedDate;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();

  // Метод для проверки всех полей
  bool _checkAllFields() {
    return taskNameController.text.isNotEmpty &&
        taskDescriptionController.text.isNotEmpty &&
        _selectedDate != null &&
        selectedPriority != null &&
        selectedStatus != null;
  }

  // Метод для обновления состояния кнопки
  void _updateButtonState() {
    final bool shouldBeActive = _checkAllFields();
    if (isActiveButton != shouldBeActive) {
      setState(() {
        isActiveButton = shouldBeActive;
      });
    }
  }

  // Слушатель изменений в текстовых полях
  @override
  void initState() {
    super.initState();
    taskNameController.addListener(_updateButtonState);
    taskDescriptionController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    taskNameController.removeListener(_updateButtonState);
    taskDescriptionController.removeListener(_updateButtonState);
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 25),

          // Title
          Center(
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Expanded(flex: 1, child: Icon(Icons.add, size: 40, color: Colors.white)),
                  Expanded(flex: 2, child: Text('Add Task', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),

          Divider(height: 25, color: Colors.white, thickness: 1, indent: 150, endIndent: 150),

          SizedBox(height: 25),

          InputCustom(
            nameInput: 'Task Name', 
            textEditingController: taskNameController,
            onChanged: (_) => _updateButtonState(), 
          ),

          SizedBox(height: 10),

          InputCustom(
            nameInput: 'Description', 
            textEditingController: taskDescriptionController,
            onChanged: (_) => _updateButtonState(), 
          ),

          // Календарь
          TableCalendarCustom(
            initialDateTime: _selectedDate, 
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
                _updateButtonState(); 
              });
            },
          ),

          SizedBox(height: 10),

          // Для приоритета
          DropdownCustom(
            isPriorityDropdown: true,
            initialPriority: selectedPriority,
            onPriorityChanged: (priority) {
              setState(() {
                selectedPriority = priority;
                _updateButtonState();
              });
            },
          ),

          SizedBox(height: 20),

          // Для статуса
          DropdownCustom(
            isPriorityDropdown: false,
            initialStatus: selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                selectedStatus = status;
                _updateButtonState(); 
              });
            },
          ),

          SizedBox(height: 35),  

          // Button add
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: isActiveButton 
                  ? MaterialStateProperty.all(Colors.green)
                  : MaterialStateProperty.all(Colors.grey),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(8),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: isActiveButton ? () {                
                _addTask(context);
              } : null, 
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 35),
                  SizedBox(width: 25),
                  Text('Add', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(BuildContext context) async {
    if (!_checkAllFields()) return;

    final taskDatabase = Provider.of<TaskDataBase>(context, listen: false);

    final int idTask = DateTime.now().millisecondsSinceEpoch;

    try {
      await taskDatabase.addTask(
        idTask,
        taskNameController.text,
        taskDescriptionController.text,
        selectedStatus!,
        selectedPriority!,
        _selectedDate!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          
          backgroundColor: Colors.transparent,
            content: Icon(Icons.check, color: Colors.green,size: 45,),
          duration: Duration(microseconds: 900),
        ),
      );

      taskNameController.clear();
      taskDescriptionController.clear();
      setState(() {
        _selectedDate = null;
        selectedPriority = null;
        selectedStatus = null;
        isActiveButton = false;
      });

      FocusScope.of(context).unfocus();

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error adding task: $e', 
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}