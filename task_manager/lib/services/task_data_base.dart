import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/models/TaskData.dart'; // исправлен импорт

class TaskDataBase extends ChangeNotifier { // наследуем от ChangeNotifier
  static late Isar isar;
  List<TaskData> _tasks = [];

  List<TaskData> get tasks => _tasks;

  // Инициализация Isar (должна быть static)
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskDataSchema], // или просто [TaskData]
      directory: dir.path,
    );
    
  }

  Future<void> addTask(
    int idTask, 
    String nameTask, 
    String description,
    TaskStatus status,
    TaskPriority priority,
    DateTime dateTime,
  ) async {
    final newTask = TaskData(
      idTask: idTask, 
      name: nameTask, 
      description: description, 
      status: status, 
      dateTime: dateTime, 
      priority: priority
    );
    await isar.writeTxn(() => isar.taskDatas.put(newTask));
    await fetchTasks();
    notifyListeners(); // уведомляем слушателей
  }

  Future<void> fetchTasks() async {
    List<TaskData> fetchedTask = await isar.taskDatas.where().findAll();
    _tasks.clear();
    _tasks.addAll(fetchedTask);
    notifyListeners(); // уведомляем слушателей
  }

  Future<void> updateTask(int id, TaskStatus status) async {
    final existingTask = await isar.taskDatas.get(id);
    if (existingTask != null) {
      existingTask.status = status;
      await isar.writeTxn(() => isar.taskDatas.put(existingTask));
      await fetchTasks();
    }
  }

  Future<void> deleteTask(int id) async { // исправлено имя метода
    await isar.writeTxn(() => isar.taskDatas.delete(id));
    await fetchTasks();
  }
}