import 'package:flutter/material.dart';
import 'package:task_manager/models/TaskData.dart';

class DropdownCustom extends StatefulWidget {
  final TaskStatus? initialStatus;
  final TaskPriority? initialPriority;
  final ValueChanged<TaskStatus?>? onStatusChanged;
  final ValueChanged<TaskPriority?>? onPriorityChanged;
  final bool isPriorityDropdown; // true - приоритет, false - статус

  const DropdownCustom({
    super.key,
    this.initialStatus,
    this.initialPriority,
    this.onStatusChanged,
    this.onPriorityChanged,
    required this.isPriorityDropdown,
  });

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  TaskStatus? _selectedStatus;
  TaskPriority? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
    _selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPriorityDropdown 
        ? _buildPriorityDropdown()
        : _buildStatusDropdown();
  }

  Widget _buildPriorityDropdown() {
    return SizedBox(
      width: 300,
      height: 50,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.5
          ),
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        child: DropdownButton<TaskPriority>(

          value: _selectedPriority,
          hint: Text('Select priority', style: TextStyle(color: Colors.white, fontSize: 20),),
          isExpanded: true,
          underline: Container(),
          onChanged: (TaskPriority? newValue) {
            setState(() {
              _selectedPriority = newValue;
            });
            widget.onPriorityChanged?.call(newValue);
          },
          dropdownColor: Colors.grey.shade300,
          items: TaskPriority.values.map<DropdownMenuItem<TaskPriority>>((priority) {
            return DropdownMenuItem<TaskPriority>(
              value: priority,
              child: Row(
                children: [
                  Icon(priority.icon, color: priority.color, size: 20),
                  SizedBox(width: 8),
                  Text(priority.displayName, style: TextStyle(color: Colors.white, fontSize: 20),),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return SizedBox(
      width: 300,
      height: 50,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.5
          ),
          borderRadius: BorderRadius.circular(16),
         color: Colors.transparent, 
        ),
        child: DropdownButton<TaskStatus>(
          underline: Container(),
          value: _selectedStatus,
          hint: Text('Select status', style: TextStyle(color: Colors.white, fontSize: 20),),
          isExpanded: true,
          onChanged: (TaskStatus? newValue) {
            setState(() {
              _selectedStatus = newValue;
            });
            widget.onStatusChanged?.call(newValue);
          },
          dropdownColor: Colors.grey.shade300,
          items: TaskStatus.values.map<DropdownMenuItem<TaskStatus>>((status) {
            return DropdownMenuItem<TaskStatus>(
              value: status,
              child: Row(
                children: [
                  Icon(status.icon, color: status.color, size: 20),
                  SizedBox(width: 8),
                  Text(status.displayName, style: TextStyle(color: Colors.white, fontSize: 20),),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}