import 'package:flutter/material.dart';

class BuildFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final FormFieldValidator<String> validate;
  final IconData prefix;
  final bool isPassword;
  final IconData? suffix;
  final Function(String value)? submit;
  final Function(String value)? onChange;
  final VoidCallback? suffixPressed;

  const BuildFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.type,
    required this.validate,
    required this.prefix,
    this.isPassword = false,
    this.suffix,
    this.submit,
    this.onChange,
    this.suffixPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffix)),
      ),
      validator: validate,
      obscureText: isPassword,
      onFieldSubmitted: submit,
      onChanged: onChange,
    );
  }
}
