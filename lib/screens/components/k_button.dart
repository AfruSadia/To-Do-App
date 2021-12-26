import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class Button extends StatelessWidget {
  final String button;
  final Color color;
  Button({required this.button, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.00),
        color: color,
      ),
      child: Center(
        child: Text(
          button,
          style: TextStyle(color: KColor.k_white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
