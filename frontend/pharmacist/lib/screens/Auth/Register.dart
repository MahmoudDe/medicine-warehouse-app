import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medicine_warehouse/server/server.dart';
import 'package:medicine_warehouse/widgets/border_button.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
class RegisterPage extends StatelessWidget {
  Server server = new Server();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text('Register Page', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(controller: emailController, prefixIconData: Iconsax.profile_circle5, hintText: 'Enter new Email'),
            SizedBox(height: 20),
            CustomTextField(controller: passwordController, prefixIconData: Iconsax.lock, hintText: 'Enter new Password'),
            SizedBox(height: 20),
            CustomTextField(controller: confirmPasswordController, prefixIconData: Iconsax.lock, hintText: 'Confirm Password'), // Add custom field for password confirmation
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              child: BorderButton(
                text: 'Register',
                onPressed: () async {
                  if (passwordController.text == confirmPasswordController.text) {
                    try {
                      await server.registerUser(emailController.text, passwordController.text);
                      // Show success Snackbar upon successful registration
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Registration successful'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      // Show error Snackbar if registration fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Registration failed: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    // Show an error if passwords don't match
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIconData; // Add a variable for prefix icon data

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIconData, // Modify constructor to accept prefix icon data
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.lato(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(prefixIconData), // Set the prefix icon using the IconData
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.cyan.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomElevatedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        elevation: MaterialStateProperty.all(10),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
