import 'package:flutter/material.dart';

import 'package:task_manager/models/ColorGradient.dart';
import 'package:task_manager/models/TaskData.dart';
import 'package:task_manager/services/task_data_base.dart';
import 'package:provider/provider.dart';

class CardItemProject extends StatefulWidget {
  final TaskData task;
  final Function(TaskStatus)? onStatusChanged;
  
  const CardItemProject({
    super.key,
    required this.task,
    this.onStatusChanged,
  });

  @override
  State<CardItemProject> createState() => _CardItemProjectState();
}

class _CardItemProjectState extends State<CardItemProject>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _rotationAnimation;
  late TaskStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.task.status;
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _changeStatus(TaskStatus newStatus) {
    setState(() {
      _currentStatus = newStatus;
    });
    
    if (widget.onStatusChanged != null) {
      widget.onStatusChanged!(newStatus);
    }
  }

  void _showStatusMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<TaskStatus>(
      context: context,
      position: position,
      items: TaskStatus.values.map((status) {
        return PopupMenuItem<TaskStatus>(
          value: status,
          child: Row(
            children: [
              Text(status.name),
            ],
          ),
        );
      }).toList(),
    ).then((selectedStatus) {
      if (selectedStatus != null) {
        _changeStatus(selectedStatus);
      }
    });
  }

  // Метод для удаления задачи
  void _deleteTask(BuildContext context) async {
    final taskDatabase = Provider.of<TaskDataBase>(context, listen: false);
    
    //Диалог подтверждения
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey[900],
          content: Text('Are you sure you want to delete this task?', 
            style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    ) ?? false;

    if (confirmDelete) {
      try {
        await taskDatabase.deleteTask(widget.task.id);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Task deleted successfully!', 
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            duration: Duration(seconds: 2),
          ),
        );
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error deleting task: $e', 
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: Colorgradient.getByName('Evening sunset'),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            // Заголовок карточки
            ListTile(          
              title: Text(
                widget.task.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              trailing: RotationTransition(
                turns: _rotationAnimation,
                child: const Icon(Icons.expand_more, color: Colors.white),
              ),
              onTap: _toggleExpansion,
            ),
        
            // Раскрывающееся содержимое
            SizeTransition(
              sizeFactor: _heightAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Description
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.task.description,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                            ),
                            softWrap: true, 
                            overflow: TextOverflow.visible, 
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    //Date
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text('Date', 
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        SizedBox(height: 5,),

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.task.dateTime.day}.${widget.task.dateTime.month}.${widget.task.dateTime.year}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),                        
                      ],
                    ),
                    
                    const SizedBox(height: 25),
        
                    // Status and priority
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            // Status Column
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _showStatusMenu(context),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2), 
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          _currentStatus.name,
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white70,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
        
                            // Priority Column
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Priority',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2), 
                                  Text(
                                    widget.task.priority.name,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25,),

                    // Кнопка удаления
                    SizedBox(
                      width: 150,
                      height: 50,                      
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          _deleteTask(context); 
                        }, 
                        child: Row(
                          children: [
                            Icon(Icons.delete_forever_outlined, color: Colors.white, size: 25),
                            SizedBox(width: 5),
                            Text('Delete', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}