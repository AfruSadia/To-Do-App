import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class KTextFields extends StatefulWidget {
  final decoration;
  final keyboardtype;
  final TextEditingController? controller;
  final validator, readonly;
  final onTap;
  bool obsecuretext;

  KTextFields(
      {this.onTap,
      this.controller,
      required this.obsecuretext,
      required this.decoration,
      this.keyboardtype,
      this.validator,
      this.readonly});

  @override
  State<KTextFields> createState() => _KTextFieldsState();
}

class _KTextFieldsState extends State<KTextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        readOnly: widget.readonly,
        onTap: widget.onTap,
        keyboardType: widget.keyboardtype,
        obscureText: widget.obsecuretext,
        controller: widget.controller,
        decoration: widget.decoration,
        validator: widget.validator,
      ),
    );
  }
}
