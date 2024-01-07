import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool readOnly;
  final TextEditingController controller;
  final TextStyle? hintstyle;
  final String ? label;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle?errorStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final type;
  final TextStyle? style;
  final maxlines;
  const CustomTextFormField({
    Key? key,
    this.hintstyle,
    this.errorStyle,
    this.label,
    this.readOnly=false,
    this.style,
    required this.controller,
    this.maxlines=1,
    this.type=TextInputType.text,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      readOnly: widget.readOnly,
      style:Theme.of(context).textTheme.bodySmall ,
      maxLines: widget.maxlines,
      keyboardType: widget.type,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText:widget.label,
        errorStyle: TextStyle(color: Colors.red),
        hintStyle: Theme.of(context).textTheme.bodySmall,
        hintText: widget.hintText,
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //     borderSide: BorderSide(color: const Color.fromARGB(255, 220, 111, 111))
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white)
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,

          color: Colors.white,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : widget.suffixIcon,
      ),
      obscureText: widget.obscureText && _obscureText,
      validator: widget.validator,
    );
  }
}