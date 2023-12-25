import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final ValueChanged<String>? onChanged;


  CustomTextField({required this.controller, required this.hintText, required this.prefixIcon, this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasError = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _hasError ? 80 : 50, // Change the height based on whether an error exists
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(

        controller: widget.controller,
        style: GoogleFonts.lato(
          fontSize: 16,
          color: Colors.black,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _hasError = true;
            });
            return 'Please Enter your data!';
          }
          setState(() {
            _hasError = false;
          });
          return null;
        },

        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.controller.clear();
            },
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.cyan.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontSize: 14,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}


