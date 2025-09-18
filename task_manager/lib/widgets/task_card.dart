import 'package:flutter/material.dart';
import 'package:task_manager/models/TestData.dart';
import 'package:task_manager/models/ColorGradient.dart';

class CardItemProject extends StatefulWidget {
  final Testdata testdata;
  
  const CardItemProject(
    {
      super.key,
      required this.testdata,
    }
  );

  @override
  State<CardItemProject> createState() => _CardItemProjectState();
}

class _CardItemProjectState extends State<CardItemProject>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: Colorgradient.getByName('Forest'),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
        
            // Заголовок карточки
            ListTile(          
              title: Text(
                widget.testdata.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              trailing: RotationTransition(
                turns: _rotationAnimation,
                child: const Icon(Icons.expand_more),
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
        
                    //Description
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            'Ваш длинный текст здесь...fdglkjdfglkjglkdfjglkdjglkdfjglkdjglkdjglkdjgdlkjgdlkjgdlkgjdlgkjdflkgkdjfglkdfjglkfdjglkdfjglkdfjglkdfjglkdfjglk',
                            softWrap: true, 
                            overflow: TextOverflow.visible, 
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 25,),
        
                    // Status and priority
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Вместо spacing
                                  Text('В процессе'),
                                ],
                              ),
                            ),
        
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Priority',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5), // Вместо spacing
                                  Text('data'),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
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