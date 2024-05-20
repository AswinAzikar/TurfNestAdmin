import 'package:flutter/material.dart';

class ToggleButtonWidget extends StatefulWidget {
  final Function() onPressed;

  const ToggleButtonWidget({
    required this.onPressed,
    super.key,
  });

  @override
  _ToggleButtonWidgetState createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(24),
      fillColor: Colors.blue,
      color: Colors.white,
      selectedColor: Colors.white,
      children: [
        Icon(
          Icons.menu,
          color: _isSelected[0] ? Colors.white : Colors.black,
        ),
        Icon(
          Icons.settings,
          color: _isSelected[1] ? Colors.white : Colors.black,
        ),
      ],
      isSelected: _isSelected,
      onPressed: (index) {
        setState(() {
          _isSelected = [false, false];
          _isSelected[index] = true;
          widget.onPressed();
        });
      },
    );
  }
}
