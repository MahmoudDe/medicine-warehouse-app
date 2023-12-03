import 'package:flutter/material.dart';
import 'package:warehouse_owner_app/widgets/BorderButton.dart';
import 'package:warehouse_owner_app/widgets/TextField.dart';

import '../Server/server.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.cyan.shade700,
        body: Center(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 1.5,
              child: Card(
                elevation: 3.0,
                color: Colors.grey.shade100,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                              width: screenSize.width / 3,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 30.0, bottom: 10.0, right: 150),
                                      child: Text(
                                        "Welcome to the Warehouse!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35,
                                            fontFamily: "Avenir",
                                            color: Colors.cyan),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          right: 330.0, bottom: 10.0),
                                      child: Text(
                                        "Enter your Email: ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                    CustomTextField(
                                      controller: _emailController,
                                      hintText: 'Email',
                                      prefixIcon: Icons.email,
                                    ),
                                    const SizedBox(height: 20),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          right: 300.0, bottom: 10.0),
                                      child: Text(
                                        "Enter your Password: ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: 'Password',
                                      prefixIcon: Icons.lock,
                                    ),
                                    const SizedBox(height: 20),
                                  ])),
                        ),
                        BorderButton(
                          text: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              Server server = Server();
                              await server.loginAdmin(email, password);

                              Navigator.pushNamed(context, '/home');
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
