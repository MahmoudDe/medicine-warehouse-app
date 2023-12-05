import 'package:flutter/material.dart';

import 'categories.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.cyan.shade700,

      ),
      body:  Expanded(
        child: CategoriesScreen(),
      ),
    );
  }
}
