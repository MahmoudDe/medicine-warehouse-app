import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionalTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;

  OptionalTextField({this.controller, this.hintText, this.prefixIcon, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.lato(
          fontSize: 16,
          color: Colors.black,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter your data!'; // Custom error message
          }
          // Add more complex validation here if needed
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: controller != null ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller!.clear();
            },
          ) : null,
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.cyan.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          errorStyle: TextStyle(
            color: Colors.redAccent, // change this color to change the color of the error text
            fontSize: 14, // change this size to change the size of the error text
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.red, // change this color to change the color of the error border
              width: 1, // change this size to change the width of the error border
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.red, // change this color to change the color of the error border when the field is focused
              width: 2, // change this size to change the width of the error border when the field is focused
            ),
          ),
        ),
      ),
    );
  }
}
