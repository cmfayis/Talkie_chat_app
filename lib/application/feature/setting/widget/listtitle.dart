// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Listtile extends StatelessWidget {
  final ontap;
  final Widget leading;
  final Widget title;

  const Listtile({
    Key? key,
    required this.leading,
    required this.title,
    
     this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(   
        leading:leading ,
        title: title,
      ),
    );
  }
}
