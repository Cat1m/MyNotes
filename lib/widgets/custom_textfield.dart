// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool enableSuggestions;
  final bool autoCorrect;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        enableSuggestions: enableSuggestions,
        autocorrect: autoCorrect,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          //tắt cái underline
          decorationThickness: 0,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
              vertical: 13, horizontal: 20),
          hintText: hintText,
        ),
      ),
    );
  }
}
