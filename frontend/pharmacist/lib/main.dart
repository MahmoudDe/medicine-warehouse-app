import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_warehouse/screens/HomePage.dart';
import 'package:medicine_warehouse/screens/navigation_screen.dart';
import 'package:provider/provider.dart';
import 'Provider/navigation_controller.dart';

// Import the register and login pages
import 'package:medicine_warehouse/screens/Auth/Register.dart';
import 'package:medicine_warehouse/screens/Auth/Login.dart';

void main() {
  runApp(MyApp(initialRoute: NavigationScreen.routeName));
}

class MyApp extends StatelessWidget {

  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey
    ));
    return ChangeNotifierProvider(
      create: (context) => NavigationController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.cyanAccent.shade700,
          canvasColor: Colors.grey.shade200,
          secondaryHeaderColor: Colors.orange,
          fontFamily: 'Avenir',
        ),
        initialRoute: initialRoute,
        routes: {
          '/login': (context) => LoginPage(), // Add this line
          '/register': (context) => RegisterPage(), // Add this line
          '/home': (context) => HomeScreen(),
          '/main': (context) => const NavigationScreen(),
          NavigationScreen.routeName: (context) =>  LoginPage()
        },
      ),
    );
  }
}
