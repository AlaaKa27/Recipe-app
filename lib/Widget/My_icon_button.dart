import 'package:flutter/material.dart';

class ButtonMyIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback pressed;
  const ButtonMyIcon({super.key, required this.icon, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        fixedSize: Size(50, 50),
      ),
      icon: Icon(icon),
      onPressed: pressed,
    );
  }
}
