import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget {
  final String nameInput;
  final TextEditingController textEditingController;
  
  const InputCustom(
    {
      super.key,
      required this.nameInput,
      required this.textEditingController,
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
            Positioned(
              left: 20,
              top: -15,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.nameInput,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}