import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/widgets/task_card.dart';
import 'package:task_manager/services/task_data_base.dart';

class BodyTask extends StatefulWidget {
  const BodyTask({super.key});

  @override
  State<BodyTask> createState() => _BodyTaskState();
}

class _BodyTaskState extends State<BodyTask> {
  void load() async
  {
    final taskDatabase = Provider.of<TaskDataBase>(context, listen: false);
    await taskDatabase.fetchTasks();
  }
  
  @override
  void initState() {
    super.initState();    
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDataBase>(
      builder: (context, taskDatabase, child) {
        final tasks = taskDatabase.tasks;

        return SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),

              // Title
              Center(
                child: SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.task_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'My Tasks',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(
                height: 25,
                color: Colors.white,
                thickness: 1,
                indent: 150,
                endIndent: 150,
              ),

              Center(
                child: SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: tasks.isEmpty
                        ? const Center(
                            child: Text(
                              'No tasks yet\nAdd your first task!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                ...tasks.map((task) => CardItemProject(task: task)).toList(),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}