// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double hieght;
  final  ontap;
  final Color color;
  final String text;
   CustomButton({
    Key? key,
    required this.ontap,
    required this.width,
    required this.hieght,
    required this.color,
    required this.text,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap:ontap,
                    child: Container(
                      width: width,
                      height: hieght,
                      decoration:  BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child:  Center(
                        child: Text(text,style: TextStyle(fontSize: 17.0),),
                      ),
                    ),
                  ),
                );
  }
}
