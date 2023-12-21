import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_warehouse/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'Provider/navigation_controller.dart';
import 'screens/Auth/Register.dart';
import 'screens/Auth/login.dart';
import 'screens/home_page.dart';
import 'screens/navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: 'token');

  runApp(MyApp( token: token));
}

class MyApp extends StatelessWidget {


  final String? token;

  MyApp({this.token});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(systemNavigationBarColor: Colors.grey));
    return ChangeNotifierProvider(
      create: (context) => NavigationController(),
      child: MaterialApp(
        // home: token == null ? LoginPage() : HomeScreen(),
        home: NavigationScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.cyanAccent.shade700,
          canvasColor: Colors.grey.shade200,
          secondaryHeaderColor: Colors.orange,
          fontFamily: 'Avenir',
        ),

        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomeScreen(),
          '/main': (context) => const NavigationScreen(),
        },
      ),
    );
  }
}
