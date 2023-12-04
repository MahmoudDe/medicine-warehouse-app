import 'package:flutter/material.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.cyan.shade700,

      ),
      body: Center(
        child: Text('This is the SearchPage'),
      ),
    );
  }
}
