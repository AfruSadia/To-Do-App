import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class KTextFields extends StatefulWidget {
  final decoration;
  final keyboardtype;
  final TextEditingController? controller;
  final validator;
  bool obsecuretext;

  KTextFields({
    this.controller,
    required this.obsecuretext,
    required this.decoration,
    required this.keyboardtype,
    this.validator,
  });

  @override
  State<KTextFields> createState() => _KTextFieldsState();
}

class _KTextFieldsState extends State<KTextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.keyboardtype,
        obscureText: widget.obsecuretext,
        controller: widget.controller,
        decoration: widget.decoration,
        validator: widget.validator,
      ),
    );
  }
}
