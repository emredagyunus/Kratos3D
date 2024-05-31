import 'package:flutter/material.dart';
import 'package:kratos_3d_proje/companents/constants.dart';
 //my custom textfield
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? inputType;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? width;
  final Widget? suffixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.inputType,
    this.maxLines,
    this.textAlign,
    this.width,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: width ?? double.infinity,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: inputType,
          maxLines: obscureText ? 1 : maxLines,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Constants.textFieldColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:  BorderSide(color: Constants.yellowColor),
            ),
            labelText: hintText,
            labelStyle: TextStyle(color: Constants.greyColor),
            suffixIcon: suffixIcon,
          ),
          textAlign: textAlign ?? TextAlign.start,
        ),
      ),
    );
  }
}
