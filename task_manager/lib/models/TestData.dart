import 'package:task_manager/models/enums/TaskStatus.dart';
import 'package:task_manager/models/enums/TaskPriority.dart';

class Testdata 
{
  final String name;
  final int id;
  final String description;
  final TaskStatus status;
  final Taskpriority priority;
  final DateTime dateTime;

  Testdata({
    required this.name,
    required this.id,
    required this.status,
    required this.description,
    required this.priority,
    required this.dateTime,
  });
}
