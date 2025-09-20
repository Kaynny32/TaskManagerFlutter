import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/models/TaskData.dart';

class TaskDataBase with ChangeNotifier {
  late Isar isar;
  List<TaskData> _tasks = [];

  List<TaskData> get tasks => _tasks;

  // Инициализация Isar
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskDataSchema],
      directory: dir.path,
      inspector: true,
    );
    await loadTasks();
  }

  // Загрузка всех задач
  Future<void> loadTasks() async {
    _tasks = await isar.taskDatas.where().findAll();
    notifyListeners();
  }

  // Добавление задачи
  Future<int> addTask(TaskData task) async {
    final id = await isar.writeTxn(() async {
      return await isar.taskDatas.put(task);
    });
    await loadTasks();
    return id;
  }

  // Получение всех задач
  Future<List<TaskData>> getAllTasks() async {
    return await isar.taskDatas.where().findAll();
  }

  // Получение задачи по ID
  Future<TaskData?> getTaskById(int id) async {
    return await isar.taskDatas.get(id);
  }

  // Обновление задачи
  Future<void> updateTask(TaskData task) async {
    await isar.writeTxn(() async {
      await isar.taskDatas.put(task);
    });
    await loadTasks();
  }

  // Удаление задачи
  Future<void> deleteTask(int id) async {
    await isar.writeTxn(() async {
      await isar.taskDatas.delete(id);
    });
    await loadTasks();
  }

  // Получение задач по статусу
  Future<List<TaskData>> getTasksByStatus(TaskStatus status) async {
    return await isar.taskDatas
        .filter()
        .statusEqualTo(status)
        .findAll();
  }

  // Получение задач по приоритету
  Future<List<TaskData>> getTasksByPriority(TaskPriority priority) async {
    return await isar.taskDatas
        .filter()
        .priorityEqualTo(priority)
        .findAll();
  }

  // Поиск задач по имени
  Future<List<TaskData>> searchTasksByName(String name) async {
    return await isar.taskDatas
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  // Очистка всех задач
  Future<void> clearAllTasks() async {
    await isar.writeTxn(() async {
      await isar.taskDatas.clear();
    });
    _tasks.clear();
    notifyListeners();
  }

  // Получение количества задач
  Future<int> getTasksCount() async {
    return await isar.taskDatas.count();
  }
}