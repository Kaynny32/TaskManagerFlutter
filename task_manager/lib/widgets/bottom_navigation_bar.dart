import 'dart:ui';
import 'package:flutter/material.dart';

class ButtonNavigationBarCustom extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabChanged;
  
  const ButtonNavigationBarCustom(
    {
      super.key,
      required this.onTabChanged,
      required this.currentIndex,
    }
  );

  @override
  State<ButtonNavigationBarCustom> createState() => _ButtonNavigationBarCustomState();
}

class _ButtonNavigationBarCustomState extends State<ButtonNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                Expanded(
                  child:IconButton(onPressed: (){
                    widget.onTabChanged(0);
                  }, 
                  icon: Icon(Icons.task_outlined,size: 35,color: widget.currentIndex == 0? Colors.white:  Colors.grey,)
                  )
                ),
                Expanded(
                  child: IconButton(
                    onPressed: (){
                      widget.onTabChanged(1);
                    }, 
                    icon: Icon(Icons.settings,size: 35,color: widget.currentIndex == 1? Colors.white:  Colors.grey,),
                  ) 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}