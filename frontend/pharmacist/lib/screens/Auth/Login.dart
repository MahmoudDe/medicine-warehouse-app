import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medicine_warehouse/widgets/border_button.dart';

import '../../Paint.dart';
import '../../server/server.dart';
import '../../widgets/Button.dart';
import '../../widgets/text_field.dart';
import '../navigation_screen.dart';

class LoginPage extends StatelessWidget {
  Server server = new Server();

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
                    MediaQuery.of(context).size.height / 4 + 30),
                painter: WavePainter(),
              ),
               Padding(
                padding: EdgeInsets.only(top: 110.0, left: 16.0),
                child: Text(
                  (tr("welcomeToYourPharmacy")),
                  style: TextStyle(
                    fontFamily: 'Tajawal',
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
                  hintText: tr('enterYourEmail'),
                  prefixIcon: Iconsax.profile_circle),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CustomTextField(
                controller: passwordController,
                hintText: tr("enterYourPassword"),
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
                      child: BorderButton(text: tr("register"), onPressed: () {
                        Navigator.pushNamed(context, '/register');

                      }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        onPressed: () async {
                          try {
                            var loginResponse = await server.loginUser(emailController.text, passwordController.text);
                            // Show success Snackbar upon successful login
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Login successful'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // After a successful login, navigate to the home screen and remove all previous routes.
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => NavigationScreen()),
                                  (Route<dynamic> route) => false,
                            );

                          } catch (e) {
                            // Show error Snackbar if login fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Login failed: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        text: tr('login'),
                      )
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
