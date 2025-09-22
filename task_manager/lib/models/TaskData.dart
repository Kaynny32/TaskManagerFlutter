import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

part 'TaskData.g.dart';

@collection
class TaskData {
  Id id = Isar.autoIncrement;
  
  @Index()
  late int idTask;
  
  @Index()
  late String name;

  late String description;

  @Enumerated(EnumType.value, 'value')
  late TaskStatus status;
  
  @Index()
  late DateTime dateTime;

  @Enumerated(EnumType.value, 'value')
  late TaskPriority priority;

  TaskData({
    required this.idTask,
    required this.name,
    required this.description,
    required this.status,
    required this.dateTime,
    required this.priority,
  });
}

enum TaskStatus {
  pending(0),
  inProgress(1),
  completed(2),
  archived(3);

  final int value;
  const TaskStatus(this.value);

  String get displayName {
    switch (this) {
      case TaskStatus.pending:
        return 'Waiting';
      case TaskStatus.inProgress:
        return 'In progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.archived:
        return 'In the archive';
    }
  }
  
  Color get color {
    switch (this) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.archived:
        return Colors.purple;
    }
  }
  
  IconData get icon {
    switch (this) {
      case TaskStatus.pending:
        return Icons.access_time;
      case TaskStatus.inProgress:
        return Icons.play_arrow;
      case TaskStatus.completed:
        return Icons.check_circle;
      case TaskStatus.archived:
        return Icons.archive;
    }
  }
}

enum TaskPriority {
  low(0),
  medium(1),
  high(2);

  final int value;
  const TaskPriority(this.value);

  String get displayName {
    switch (this) {
      case TaskPriority.low:
        return 'Short';
      case TaskPriority.medium:
        return 'Average';
      case TaskPriority.high:
        return 'High';
    }
  }
  
  Color get color {
    switch (this) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }
  
  IconData get icon {
    switch (this) {
      case TaskPriority.low:
        return Icons.arrow_downward;
      case TaskPriority.medium:
        return Icons.remove;
      case TaskPriority.high:
        return Icons.arrow_upward;
    }
  }
}