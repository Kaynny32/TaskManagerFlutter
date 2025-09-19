import 'package:flutter/material.dart';

class TableCalendarCustom extends StatefulWidget {
  final DateTime? initialDateTime;
  final ValueChanged<DateTime?>? onDateChanged;

  const TableCalendarCustom({
    super.key,
    this.initialDateTime,
    this.onDateChanged,
  });

  @override
  State<TableCalendarCustom> createState() => _TableCalendarCustomState();
}

class _TableCalendarCustomState extends State<TableCalendarCustom> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDateTime;
  }

Future<void> _selectDueDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          // Основные цвета
          colorScheme: const ColorScheme.light(
            primary: Colors.purple, // Основной цвет (кнопки, выделение)
            onPrimary: Colors.white, // Цвет текста на primary
            surface: Colors.black, // Фон календаря
            onSurface: Colors.white, // Цвет текста
          ),
          // Стиль текстовых кнопок
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple, // Цвет текста кнопок
            ),
          ),
          // Стиль диалога
          dialogBackgroundColor: Colors.black,
          // Стиль карточек
          cardColor: Colors.black,
        ),
        child: child!,
      );
    },
  );
  
  if (picked != null) {
    setState(() {
      _selectedDate = picked;
    });
    
    if (widget.onDateChanged != null) {
      widget.onDateChanged!(picked);
    }
  }
}

  void _clearDate() {
    setState(() {
      _selectedDate = null;
    });
    if (widget.onDateChanged != null) {
      widget.onDateChanged!(null);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 75,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _selectDueDate(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _selectedDate == null
                    ? 'Select due date'
                    : 'Due: ${_formatDate(_selectedDate!)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (_selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white70),
              onPressed: _clearDate,
            ),
        ],
      ),
    );
  }
}