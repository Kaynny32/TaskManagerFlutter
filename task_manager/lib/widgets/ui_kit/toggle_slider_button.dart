import 'package:flutter/material.dart';

class ToggleSliderButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const ToggleSliderButton({
    this.initialValue = false,
    this.onChanged,
  });

  @override
  _ToggleSliderButtonState createState() => _ToggleSliderButtonState();
}

class _ToggleSliderButtonState extends State<ToggleSliderButton> {
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.initialValue;
  }

  void _toggle() {
    setState(() {
      _isActive = !_isActive;
    });
    widget.onChanged?.call(_isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 60,
        height: 36,
        decoration: BoxDecoration(
          color: _isActive ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: [        
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: _isActive ? 30 : 4, 
              top: 4,
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
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