
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final int? lines;
  final String hintText;
  const TextFieldWidget({
    Key? key,
    this.lines,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: lines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,     
        filled: true,
        fillColor: Color.fromARGB(255, 226, 233, 240),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 15.0,
        ),
      ),
      // obscureText: true,
    );
  }
}
