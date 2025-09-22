import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget {
  final String nameInput;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  
  const InputCustom(
    {
      super.key,
      required this.nameInput,
      required this.textEditingController,
      this.onChanged,
    }
  );

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [

            // TextField
            SizedBox(
              width: 300,
              height: 75,
              child: TextFormField(
                onChanged: widget.onChanged,
                controller: widget.textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Текст поверх border
            SizedBox(
              width: 300,
              height: 75,
              child: TextFormField(                
                onChanged: widget.onChanged,
                controller: widget.textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: widget.nameInput,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}