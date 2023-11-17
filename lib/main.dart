import 'package:flutter/material.dart';
import 'package:medicine_warehouse/screens/HomePage.dart';
import 'package:medicine_warehouse/screens/navigation_screen.dart';
import 'package:provider/provider.dart';
import 'Provider/navigation_controller.dart';


void main() {
  runApp(MyApp(initialRoute: NavigationScreen.routeName));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryColor: Colors.cyanAccent.shade700,
          canvasColor: Colors.grey.shade200,
          secondaryHeaderColor: Colors.orange,
          fontFamily: 'Avenir',
        ),
        initialRoute: initialRoute,
        routes: {
          '/home': (context) => HomeScreen(),
          NavigationScreen.routeName: (context) => const NavigationScreen()
        },
      ),
    );
  }
}
