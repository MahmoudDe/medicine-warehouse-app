import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_owner_app/screens/HomePage.dart';
import 'package:warehouse_owner_app/screens/LoginPage.dart';
import 'package:warehouse_owner_app/screens/NewMedicine.dart';
import 'package:warehouse_owner_app/screens/Orders.dart';
import 'package:warehouse_owner_app/widgets/CategoryInput.dart';
import 'Provider/Medicine_Provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MedicineProvider(),
      child: MyApp(initialRoute: LoginPage.routeName),
    ),
  );
}

class MyApp extends StatelessWidget {


  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.cyanAccent.shade700,
    canvasColor: Colors.grey.shade200,
    secondaryHeaderColor: Colors.orange,
    fontFamily: 'Messiri',
    ),
      initialRoute: initialRoute,
      home:  HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/orders': (context) => OrderPage(),
        '/make_medicine': (context) => NewMedicineForm(),
        '/make_category': (context) => CategoryInput(),
        LoginPage.routeName: (context) =>  LoginPage()
      },
    );
  }
}