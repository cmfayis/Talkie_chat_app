import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double? hieght;
  final double? width;
  const CustomSizedBox({super.key,this.hieght,this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght,
      width: width,
    );
  }
}