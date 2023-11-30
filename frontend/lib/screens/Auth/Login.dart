import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medicine_warehouse/widgets/BorderButton.dart';

import '../../Paint.dart';
import '../../widgets/Button.dart';
import '../../widgets/TextField.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height/4+ 30),
                painter: WavePainter(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 110.0, left: 16.0),
                child: Text(
                  "Welcome to your\npharmacy!",
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.normal,
                    fontSize: 45,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ]),
            Image.asset(
              'assets/images/login.png',
              height: 250,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your Email',
                  prefixIcon: Iconsax.profile_circle),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomTextField(
                controller: passwordController,
                hintText: "Enter your Password",
                prefixIcon: Iconsax.lock,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BorderButton(text: "Register", onPressed: (){

                      }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/main');
                        },
                        text: 'Login',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
