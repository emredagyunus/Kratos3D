import 'package:flutter/material.dart';

// my custom button
class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double? width;
  final Color colorBackground;
  final Color colorText;

  const MyButton(
      {super.key,
      this.onTap,
      required this.text,
      this.width,
      required this.colorBackground,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorText,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
